import 'package:flutter/material.dart';

import '../../../entities/skill.dart';
import 'expandable_card.dart';
import 'session_header.dart';

class CharSkillsSession extends StatefulWidget {
  final List<Skill> skills;
  final List<Skill> selectedSkills;
  final Function(Skill skill) selectSkill;

  const CharSkillsSession({
    required this.skills,
    required this.selectedSkills,
    required this.selectSkill,
    super.key,
  });

  @override
  State<CharSkillsSession> createState() => _CharSkillsSessionState();
}

class _CharSkillsSessionState extends State<CharSkillsSession> {
  bool isExpanded = false;

  toggleExpandedValue() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = "Perícias";
    final text = isExpanded ? "Ocultar ${title.toLowerCase()}" : "Alterar ${title.toLowerCase()}";

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1000
            ? 4
            : constraints.maxWidth > 760
                ? 3
                : 2;

        final List<List<Skill?>> rows = List.generate(
          (widget.skills.length / columns).ceil(),
          (rowIndex) => List.generate(
            columns,
            (columnIndex) {
              final listIndex = rowIndex * columns + columnIndex;
              if (widget.skills.length > listIndex) {
                return widget.skills[listIndex];
              } else {
                return null;
              }
            },
          ),
        );

        return Card(
          elevation: 0,
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          child: ExpandableCard(
            isExpanded: isExpanded,
            head: SessionHeader(
              title: title,
              description:
                  "Cada perícia custa 1 ponto. Ao adquirir uma, você será um perito, um grande entendido naquela área.",
              buttonLabel: text,
              onExpandButtonPressed: toggleExpandedValue,
              points: widget.selectedSkills.length,
            ),
            content: Card(
              elevation: 3 / 4,
              margin: const EdgeInsets.all(0),
              shadowColor: Colors.transparent,
              shape: const Border(),
              child: widget.skills.isEmpty
                  ? Center(
                      child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Nenhuma Perícia'),
                    ))
                  : Column(
                      children: rows
                          .map((row) => Row(
                                children: row
                                    .map((item) => Expanded(
                                          child: item != null
                                              ? SkillTile(
                                                  skill: item,
                                                  selected: widget.selectedSkills.contains(item),
                                                  onSelectButtonPress: widget.selectSkill,
                                                )
                                              : Container(),
                                        ))
                                    .toList(),
                              ))
                          .toList(),
                    ),
            ),
          ),
        );
      },
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
