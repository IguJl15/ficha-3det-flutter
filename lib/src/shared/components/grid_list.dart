import 'package:flutter/material.dart';

// Take care with performance
class GridList extends StatelessWidget {
  final int columns;
  final bool fillEmptySpaces;

  final List<Widget> children;
  // final Widget? Function(BuildContext, int) itemBuilder;

  const GridList({required this.columns, required this.children, super.key, required this.fillEmptySpaces});

  @override
  Widget build(BuildContext context) {
    final List<List<int?>> rows = List.generate(
      (children.length / columns).ceil(),
      (rowIndex) => List.generate(
        columns,
        (columnIndex) {
          final listIndex = rowIndex * columns + columnIndex;
          if (children.length > listIndex) {
            return listIndex;
          } else {
            return null;
          }
        },
      ),
    );

    return Column(
      children: rows
          .map((row) => Row(
                children: row.map(
                  (item) {
                    if (item != null) {
                      return children[item];
                    } else {
                      if (fillEmptySpaces) {
                        return Expanded(child: Container());
                      } else {
                        return Container();
                      }
                    }
                  },
                ).toList(),
              ))
          .toList(),
    );
  }
}
