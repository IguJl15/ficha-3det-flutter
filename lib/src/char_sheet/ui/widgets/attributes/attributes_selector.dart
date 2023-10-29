import '../number_stepper.dart';
import 'package:flutter/material.dart';

class AttributeSelector extends StatelessWidget {
  final Widget title;
  final int value;
  final Widget icon;
  final void Function() increment;
  final void Function() decrement;

  const AttributeSelector({
    required this.title,
    required this.value,
    required this.icon,
    required this.increment,
    required this.decrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      trailing: NumberStepper(value: value, increment: increment, decrement: decrement),
    );
  }
}
