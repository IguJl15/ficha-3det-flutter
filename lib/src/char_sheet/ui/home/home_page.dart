import 'package:ficha_3det_victory/src/localization/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../campaign/ui/campaigns_list/campaigns_list.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../data/repositories/char_sheet_repository.dart';
import '../../entities/char_sheet.dart';
import '../../models/list_chars_sheets.dart';
import 'chars_list/chars_list.dart';

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
    if (charSheet != null) {
      context.pushNamed(
        "edit",
        extra: charSheet,
        pathParameters: {'id': '${charSheet.id}'},
      ).then((value) => viewModel.fetchCharSheets());
    } else {
      context
          .pushNamed(
            "create",
            extra: charSheet,
          )
          .then((value) => viewModel.fetchCharSheets());
    }
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
        title: Text(AppLocalizations.of(context).home_appTitle),
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
          if (isSelecting)
            IconButton(onPressed: deleteSelectedCharsSheets, icon: const Icon(Icons.delete)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(context.l.home_newChar),
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

                  return Column(
                    children: [
                      CharsList(
                        isSelecting: isSelecting,
                        chars: model.charSheets,
                        selectedChars: selectedChars,
                        selectCharSheet: selectCharSheet,
                        onCharPress: pushEditCharPage,
                      ),
                      const CampaignsList(),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
