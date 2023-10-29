import '../../../entities/advantage.dart';
import '../../create_char/points_page_widgets/expandable_card.dart';
import '../number_stepper.dart';
import 'package:flutter/material.dart';

class AdvantagesList extends StatelessWidget {
  final List<Advantage> advantages;
  final List<Advantage> selectedAdvantages;
  final Function(Advantage advantage)? selectAdvantage;
  final Function(AmplifyingAdvantage advantage)? increment;
  final Function(AmplifyingAdvantage advantage)? decrement;
  final bool calculateTotalCost;
  final bool showLeading;
  final bool showTrailing;

  const AdvantagesList({
    required this.advantages,
    required this.selectedAdvantages,
    this.selectAdvantage,
    this.increment,
    this.decrement,
    this.calculateTotalCost = false,
    this.showLeading = true,
    this.showTrailing = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: advantages.map((advantage) {
        late final Widget leading;
        late final Widget trailing;

        switch (advantage) {
          case AmplifyingAdvantage():
            final selected = selectedAdvantages.any((adv) => adv.name == advantage.name);

            final selectedAdvantage = selected
                ? selectedAdvantages.singleWhere((adv) => adv.name == advantage.name) as AmplifyingAdvantage
                : null;
            final cost = calculateTotalCost ? selectedAdvantage?.points ?? 0 : advantage.cost;
            final pointsText = cost.abs() == 1 ? "$cost pt" : "$cost pts";
            trailing = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NumberStepper(
                  value: selected ? selectedAdvantage!.amount : advantage.amount,
                  increment: increment != null ? () => increment!(advantage) : null,
                  decrement: decrement != null ? () => decrement!(advantage) : null,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(pointsText)
              ],
            );
            leading = Checkbox(
              value: selected ? null : false,
              onChanged: null,
              tristate: true,
            );
            break;
          default:
            final pointsText = advantage.cost.abs() == 1 ? "${advantage.cost} pt" : "${advantage.cost} pts";

            trailing = Text(pointsText);
            leading = Checkbox(
              value: selectedAdvantages.contains(advantage),
              onChanged: (p) => selectAdvantage?.call(advantage),
            );
        }

        return switch (advantage) {
          MultipleAdvantages() =>
            AdvantagesFolder(advantage, selectedAdvantages, selectAdvantage, increment, decrement),
          _ => ListTile(
              title: Text(advantage.name),
              onTap: () {},
              leading: showLeading ? leading : null,
              trailing: showTrailing ? trailing : null,
            )
        };
      }).toList(),
    );
  }
}

class AdvantagesFolder extends StatefulWidget {
  final MultipleAdvantages advantage;
  final List<Advantage> selectedAdvantages;
  final Function(Advantage advantage)? selectAdvantage;
  final Function(AmplifyingAdvantage advantage)? increment;
  final Function(AmplifyingAdvantage advantage)? decrement;

  const AdvantagesFolder(
    this.advantage,
    this.selectedAdvantages,
    this.selectAdvantage,
    this.increment,
    this.decrement, {
    super.key,
  });

  @override
  State<AdvantagesFolder> createState() => _AdvantagesFolderState();
}

class _AdvantagesFolderState extends State<AdvantagesFolder> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isExpanded ? Theme.of(context).colorScheme.surface.withOpacity(0.65) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpandableCard(
        isExpanded: isExpanded,
        head: ListTile(
          title: Text(widget.advantage.name),
          onTap: () => setState(() => isExpanded = !isExpanded),
          trailing: const Icon(Icons.arrow_drop_down),
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(Icons.folder),
          ),
        ),
        content: AdvantagesList(
          advantages: widget.advantage.options,
          selectedAdvantages: widget.selectedAdvantages,
          selectAdvantage: widget.selectAdvantage,
          increment: widget.increment,
          decrement: widget.decrement,
        ),
      ),
    );
  }
}
