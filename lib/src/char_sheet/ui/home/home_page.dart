// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ficha_3det_victory/src/shared/components/grid_list.dart';
import 'package:ficha_3det_victory/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ficha_3det_victory/src/char_sheet/data/repositories/char_sheet_repository.dart';
import 'package:ficha_3det_victory/src/char_sheet/entities/char_sheet.dart';
import 'package:ficha_3det_victory/src/char_sheet/models/list_chars_sheets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loadedViewModel = false;
  late final CharSheetsListViewModel viewModel;

  final selectedChars = <CharSheet>[];
  bool get isSelecting => selectedChars.isNotEmpty;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      setState(() {
        viewModel = CharSheetsListViewModel(LocalCharSheetsRepository(value));
        loadedViewModel = true;

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          viewModel.fetchCharSheets();
        });
      });
    });
  }

  void pushEditCharPage(CharSheet? charSheet) {
    context.pushNamed(
      "edit",
      extra: charSheet,
      pathParameters: {if (charSheet != null) 'id': '${charSheet.id}'},
    ).then((value) => viewModel.fetchCharSheets());
  }

  void selectCharSheet(CharSheet charSheet) {
    setState(() {
      if (selectedChars.contains(charSheet)) {
        selectedChars.remove(charSheet);
      } else {
        selectedChars.add(charSheet);
      }
    });
  }

  void selectAllCharsSheets() {
    setState(() {
      selectedChars.clear();

      selectedChars.addAll(viewModel.charSheets);
    });
  }

  void deselectAllCharsSheets() {
    setState(() {
      selectedChars.clear();
    });
  }

  void deleteSelectedCharsSheets() {
    viewModel.deleteCharSheets(selectedChars.map((e) => e.id).toList());

    setState(() {
      selectedChars.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    const progress = Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fichas 3DeT Victory"),
        leading: !isSelecting
            ? null
            : Checkbox(
                value: selectedChars.length == viewModel.charSheets.length
                    ? true
                    : selectedChars.isNotEmpty
                        ? null
                        : false,
                tristate: true,
                onChanged: (checked) {
                  if (checked == false) {
                    selectAllCharsSheets();
                  } else if (checked == null) {
                    deselectAllCharsSheets();
                  }
                },
              ),
        actions: [
          if (isSelecting) IconButton(onPressed: deleteSelectedCharsSheets, icon: const Icon(Icons.delete)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Novo"),
        icon: const Icon(Icons.add),
        onPressed: () => pushEditCharPage(null),
      ),
      body: !loadedViewModel
          ? progress
          : ChangeNotifierProvider.value(
              value: viewModel,
              child: Consumer<CharSheetsListViewModel>(
                builder: (context, model, child) {
                  if (model.isLoading) {
                    return progress;
                  } else if (model.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(model.error),
                      ),
                    );
                    // return const Text('Erro');
                  }

                  return LayoutBuilder(
                    builder: (_, constrains) {
                      int columns = switch (constrains.maxWidth) {
                        < 500 => 1,
                        < 800 => 2,
                        < 1100 => 3,
                        < 1500 => 4,
                        _ => 5,
                      };

                      return GridList(
                        fillEmptySpaces: true,
                        columns: columns,
                        children: List.generate(
                          model.charSheets.length,
                          (index) {
                            final charSheet = model.charSheets[index];

                            return Expanded(
                              child: CharSheetTile(
                                charSheet: charSheet,
                                isSelecting: isSelecting,
                                isSelected: selectedChars.contains(charSheet),
                                onTap: () => isSelecting ? selectCharSheet(charSheet) : pushEditCharPage(charSheet),
                                onLongPress: () => selectCharSheet(charSheet),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}

class CharSheetTile extends StatelessWidget {
  final CharSheet charSheet;
  final bool isSelecting;
  final bool isSelected;

  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CharSheetTile({
    super.key,
    required this.charSheet,
    required this.isSelecting,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(charSheet.name),
        subtitle: Text("${charSheet.points} pontos"),
        onTap: onTap,
        onLongPress: onLongPress,
        visualDensity: VisualDensity.standard,
        selected: isSelected,
        tileColor: context.theme.colorScheme.surfaceVariant,
        selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: context.theme.textTheme.titleMedium,
        leading: CircleAvatar(
          radius: 24,
          backgroundImage:
              charSheet.profilePhotoUrl != null ? FileImage(File(charSheet.profilePhotoUrl!), scale: 0.1) : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isSelected)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
                  ),
                  child: const Icon(Icons.check),
                ),
              if (!isSelected && charSheet.profilePhotoUrl == null)
                charSheet.name.length >= 2 ? Text(charSheet.name.substring(0, 2)) : const Icon(Icons.person_outline),
            ],
          ),
        ),
      ),
    );
  }
}
