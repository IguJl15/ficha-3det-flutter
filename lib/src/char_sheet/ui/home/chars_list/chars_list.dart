import 'dart:io';

import 'package:ficha_3det_victory/src/char_sheet/entities/char_sheet.dart';
import 'package:ficha_3det_victory/src/shared/components/grid_list.dart';
import 'package:ficha_3det_victory/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CharsList extends StatelessWidget {
  final bool isSelecting;
  final List<CharSheet> chars;
  final List<CharSheet> selectedChars;

  final Function(CharSheet) selectCharSheet;
  final Function(CharSheet) onCharPress;

  const CharsList({
    super.key,
    required this.isSelecting,
    required this.chars,
    required this.selectedChars,
    required this.selectCharSheet,
    required this.onCharPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Text(
            context.l.home_characters,
            style: context.theme.textTheme.headlineSmall,
          ),
        ),
        LayoutBuilder(
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
                chars.length,
                (index) {
                  final charSheet = chars[index];

                  return Expanded(
                    child: CharSheetTile(
                      charSheet: charSheet,
                      isSelecting: isSelecting,
                      isSelected: selectedChars.contains(charSheet),
                      onTap: () =>
                          isSelecting ? selectCharSheet(charSheet) : onCharPress(charSheet),
                      onLongPress: () => selectCharSheet(charSheet),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
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
      child: Card(
        elevation: 1 / 2,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(0),
        child: ListTile(
          title: Text(charSheet.name),
          subtitle: Text("${charSheet.points} pontos"),
          onTap: onTap,
          selected: isSelected,
          onLongPress: onLongPress,
          tileColor: context.theme.colorScheme.surface,
          selectedTileColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
          titleTextStyle: context.theme.textTheme.titleMedium,
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: charSheet.profilePhotoUrl != null
                ? FileImage(File(charSheet.profilePhotoUrl!), scale: 0.1)
                : null,
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
                  charSheet.name.length >= 2
                      ? Text(charSheet.name.substring(0, 2))
                      : const Icon(Icons.person_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
