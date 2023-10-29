import 'attributes.dart';

class Resources {
  final int action;
  final int mana;
  final int health;

  const Resources(this.action, this.mana, this.health);

  factory Resources.fromAttributes(Attributes attributes) =>
      Resources(attributes.power, attributes.ability * 5, attributes.resistance * 5);
}
