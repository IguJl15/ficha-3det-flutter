import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  final int value;
  final Function()? increment;
  final Function()? decrement;
  final TextStyle? style;

  const NumberStepper({
    required this.value,
    this.increment,
    this.decrement,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: decrement, icon: const Icon(Icons.remove)),
        Container(
          width: 24,
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        IconButton(onPressed: increment, icon: const Icon(Icons.add)),
      ],
    );
  }
}
