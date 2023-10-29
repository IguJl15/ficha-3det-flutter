class Disadvantage extends Advantage {
  Disadvantage(
    super.id,
    super.name,
    super.cost,
  );
}

class Advantage {
  final int id;
  final String name;
  final String description;
  final int cost;
  final MultipleAdvantages? parent;

  bool get hasParent => parent != null;
  int get points => cost;

  const Advantage(this.name, this.description, [this.cost = 1, this.id = -1, this.parent]);

  Advantage copyWithParent(MultipleAdvantages parent) {
    return Advantage(name, description, cost, id, parent);
  }
}

class AmplifyingAdvantage extends Advantage {
  final int amount;

  @override
  int get points => amount * cost;

  AmplifyingAdvantage(
    super.name,
    super.description, [
    super.cost,
    this.amount = 0,
    super.id,
    super.parent,
  ]);

  AmplifyingAdvantage incrementedByOne() => _copyIncrementedBy(1);
  AmplifyingAdvantage decrementedByOne() => _copyIncrementedBy(-1);

  AmplifyingAdvantage _copyIncrementedBy(int value) =>
      AmplifyingAdvantage(name, description, cost, amount + value, id, parent);
}

class MultipleAdvantages extends Advantage {
  final MultipleAdvantageType type;
  late final List<Advantage> options;
  final String supportDescription;

  MultipleAdvantages(
    super.name,
    super.description,
    this.supportDescription,
    List<Advantage> options, [
    this.type = MultipleAdvantageType.multipleChoices,
    super.id,
  ]) {
    this.options = options.map((e) => e.copyWithParent(this)).toList();
  }
}

enum MultipleAdvantageType {
  multipleChoices,
  singleChoice;
}
