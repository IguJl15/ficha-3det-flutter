import 'package:flutter/material.dart';

class RemainingPoints extends StatelessWidget {
  final int remainingPoints;
  const RemainingPoints({required this.remainingPoints, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$remainingPoints",
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          "pontos restantes",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
