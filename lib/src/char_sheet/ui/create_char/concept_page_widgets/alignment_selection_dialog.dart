import 'dart:math';

import 'package:ficha_3det_victory/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../entities/char_alignment.dart';

class AlignmentSelectionDialog extends StatefulWidget {
  const AlignmentSelectionDialog({super.key});

  @override
  State<AlignmentSelectionDialog> createState() => _AlignmentSelectionDialogState();
}

class _AlignmentSelectionDialogState extends State<AlignmentSelectionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Alinhamento",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 550,
              child: ShaderMask(
                blendMode: BlendMode.modulate,
                shaderCallback: (bounds) {
                  return SweepGradient(
                    colors: MediaQuery.of(context).platformBrightness == Brightness.light
                        ? [
                            Colors.red.shade50,
                            Colors.yellow.shade50,
                            Colors.green.shade50,
                            Colors.blue.shade50,
                            Colors.blue.shade50,
                            Colors.yellow.shade50,
                            Colors.red.shade50,
                          ]
                        : [
                            Colors.red.shade100,
                            Colors.yellow.shade100,
                            Colors.green.shade100,
                            Colors.blue.shade100,
                            Colors.blue.shade100,
                            Colors.yellow.shade100,
                            Colors.red.shade100,
                          ],
                    tileMode: TileMode.mirror,
                    startAngle: pi / 4,
                    endAngle: pi * 2 + pi / 4,
                  ).createShader(bounds);
                },
                child: GridView.count(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List.generate(
                    CharAlignment.values.length,
                    (index) => Card(
                      clipBehavior: Clip.antiAlias,
                      color: Theme.of(context).colorScheme.surface,
                      child: InkWell(
                        onTap: () => Navigator.pop(context, CharAlignment.values[index]),
                        child: Center(
                          child: Text(
                            context.l.charAlignment(CharAlignment.values[index].localizationString),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
