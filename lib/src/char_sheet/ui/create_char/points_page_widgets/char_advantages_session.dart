import 'package:flutter/material.dart';

import '../../../../shared/extensions/list_extensions.dart';
import '../../../entities/advantage.dart';
import '../../../entities/skill.dart';
import '../../widgets/advantage_list/advantages_list.dart';
import 'expandable_card.dart';
import 'session_header.dart';

class CharAdvantagesSession extends StatelessWidget {
  final List<Advantage> selectedAdvantages;

  final Function(AmplifyingAdvantage advantage) increment;
  final Function(AmplifyingAdvantage advantage) decrement;

  final void Function() onButtonPressed;

  const CharAdvantagesSession({
    required this.selectedAdvantages,
    required this.increment,
    required this.decrement,
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _CharAdvantageSession(
      title: "Vantagens",
      description: "Você pode usar seus pontos para comprar vantagens. "
          "Não há limite para quantas vantagens um personagem pode ter, se puder pagar por elas.",
      selectedAdvantages: selectedAdvantages.where((e) => e.cost >= 0).toList(),
      increment: increment,
      decrement: decrement,
      onButtonPressed: onButtonPressed,
    );
  }
}

class CharDisadvantageSession extends StatelessWidget {
  final List<Advantage> selectedDisadvantages;

  final Function(AmplifyingAdvantage advantage) increment;
  final Function(AmplifyingAdvantage advantage) decrement;

  final void Function() onButtonPressed;

  const CharDisadvantageSession({
    required this.selectedDisadvantages,
    required this.increment,
    required this.decrement,
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _CharAdvantageSession(
      title: "Desvantagens",
      description:
          "Você pode usar seus pontos para comprar desvantagens. inicialmente, você pode ter até 2 desvantagens",
      selectedAdvantages: selectedDisadvantages.where((e) => e.cost < 0).toList(),
      increment: increment,
      decrement: decrement,
      onButtonPressed: onButtonPressed,
    );
  }
}

class _CharAdvantageSession extends StatelessWidget {
  final String title;
  final String description;

  final List<Advantage> selectedAdvantages;

  final Function(AmplifyingAdvantage advantage) increment;
  final Function(AmplifyingAdvantage advantage) decrement;

  final void Function() onButtonPressed;

  const _CharAdvantageSession({
    required this.title,
    required this.description,
    required this.selectedAdvantages,
    required this.increment,
    required this.decrement,
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: ExpandableCard(
        isExpanded: true,
        head: SessionHeader(
          title: title,
          description: description,
          points: selectedAdvantages.sumOf((element) => element.points),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Ver todas as ${title.toLowerCase()}"), const Icon(Icons.keyboard_arrow_right)],
          ),
          onExpandButtonPressed: onButtonPressed,
        ),
        content: Card(
          elevation: 3 / 4,
          margin: const EdgeInsets.all(0),
          shadowColor: Colors.transparent,
          shape: const Border(),
          child: AdvantagesList(
            advantages: selectedAdvantages,
            selectedAdvantages: selectedAdvantages,
            increment: increment,
            decrement: decrement,
            showLeading: false,
            calculateTotalCost: true,
          ),
        ),
      ),
    );
  }
}

class SkillTile extends StatelessWidget {
  final Skill skill;
  final bool selected;
  final Function(Skill skill) onSelectButtonPress;

  const SkillTile({
    required this.skill,
    required this.selected,
    required this.onSelectButtonPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(skill.title),
      isThreeLine: false,
      visualDensity: VisualDensity.compact,
      trailing: Checkbox(
        value: selected,
        onChanged: (p) => onSelectButtonPress(skill),
      ),
    );
  }
}
