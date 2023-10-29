// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ficha_3det_victory/src/char_sheet/entities/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../../../entities/attributes.dart';
import '../../../models/edit_char_sheet.dart';
import '../../widgets/attributes/attributes_selector.dart';
import 'expandable_card.dart';
import 'session_header.dart';

class CharAttributesSession extends StatefulWidget {
  final Attributes attributes;
  final Resources resources;
  final int pointsSpent;
  final void Function(CharAttribute attribute) incrementAttribute;
  final void Function(CharAttribute attribute) decrementAttribute;

  const CharAttributesSession({
    required this.attributes,
    required this.resources,
    required this.pointsSpent,
    required this.incrementAttribute,
    required this.decrementAttribute,
    super.key,
  });

  @override
  State<CharAttributesSession> createState() => _CharAttributesSessionState();
}

class _CharAttributesSessionState extends State<CharAttributesSession> {
  bool isExpanded = false;

  toggleExpandedValue() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = "Atributos";
    final text = isExpanded ? "Ocultar ${title.toLowerCase()}" : "Alterar ${title.toLowerCase()}";

    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: ExpandableCard(
        isExpanded: isExpanded,
        head: SessionHeader(
          title: title,
          description: "1 ponto de personagem compra 1 ponto de atributo até o máximo de 5",
          buttonLabel: text,
          onExpandButtonPressed: toggleExpandedValue,
          points: widget.pointsSpent,
        ),
        content: Card(
          elevation: 3 / 4,
          margin: const EdgeInsets.all(0),
          shadowColor: Colors.transparent,
          shape: const Border(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: _Attributes(
                          attributes: widget.attributes,
                          incrementAttribute: widget.incrementAttribute,
                          decrementAttribute: widget.decrementAttribute,
                        ),
                      ),
                      VerticalDivider(
                        width: 0,
                        color: Theme.of(context).colorScheme.outlineVariant,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Flexible(child: _Resources(resources: widget.resources))
                    ],
                  ),
                );
              } else {
                return ExpandableCarousel(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    showIndicator: true,
                    physics: PageScrollPhysics(),
                    slideIndicator: CircularWaveSlideIndicator(
                      indicatorRadius: 4,
                      itemSpacing: 12,
                      currentIndicatorColor: Theme.of(context).colorScheme.outline,
                      indicatorBackgroundColor: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  items: [
                    _Attributes(
                      attributes: widget.attributes,
                      incrementAttribute: widget.incrementAttribute,
                      decrementAttribute: widget.decrementAttribute,
                    ),
                    _Resources(resources: widget.resources)
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _Attributes extends StatelessWidget {
  final Attributes attributes;
  final void Function(CharAttribute attribute) incrementAttribute;
  final void Function(CharAttribute attribute) decrementAttribute;

  const _Attributes({
    required this.attributes,
    required this.incrementAttribute,
    required this.decrementAttribute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AttributeSelector(
          value: attributes.power,
          title: const Text("Poder"),
          icon: const Icon(Icons.fitness_center),
          increment: () => incrementAttribute(CharAttribute.power),
          decrement: () => decrementAttribute(CharAttribute.power),
        ),
        AttributeSelector(
          value: attributes.ability,
          title: const Text("Habilidade"),
          icon: const Icon(Icons.fitness_center),
          increment: () => incrementAttribute(CharAttribute.ability),
          decrement: () => decrementAttribute(CharAttribute.ability),
        ),
        AttributeSelector(
          value: attributes.resistance,
          title: const Text("Resistencia"),
          icon: const Icon(Icons.fitness_center),
          increment: () => incrementAttribute(CharAttribute.resistance),
          decrement: () => decrementAttribute(CharAttribute.resistance),
        ),
      ],
    );
  }
}

class _Resources extends StatelessWidget {
  final Resources resources;
  const _Resources({required this.resources, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text("Ponto de Ação"),
          trailing: Text("${resources.action}"),
          leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        ListTile(
          title: const Text("Ponto de Mana"),
          trailing: Text("${resources.mana}"),
          leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        ListTile(
          title: const Text("Ponto de Vida"),
          trailing: Text("${resources.health}"),
          leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
