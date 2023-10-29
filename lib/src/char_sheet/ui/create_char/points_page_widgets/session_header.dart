import 'package:flutter/material.dart';

class SessionHeader extends StatelessWidget {
  final String title;
  final String description;
  final String? buttonLabel;
  final Widget? label;
  final int points;
  final void Function() onExpandButtonPressed;

  const SessionHeader({
    required this.title,
    required this.description,
    this.buttonLabel,
    this.label,
    required this.points,
    required this.onExpandButtonPressed,
    super.key,
  }) : assert(buttonLabel != null || label != null);

  @override
  Widget build(BuildContext context) {
    final pointsText = points.abs() == 1 ? " pt" : " pts";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text("$points$pointsText"),
              ),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 8),
          //
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          //
          SizedBox(
            width: double.maxFinite,
            child: TextButton(
              onPressed: onExpandButtonPressed,
              child: label ?? Text(buttonLabel!),
            ),
          ),
        ],
      ),
    );
  }
}
