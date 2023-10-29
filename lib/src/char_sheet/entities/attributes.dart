import '../../shared/extensions/list_extensions.dart';

final class Attributes {
  final List<AttributeValue> powerValues;
  int get power => powerValues.sumAllValues();

  final List<AttributeValue> abilityValues;
  int get ability => abilityValues.sumAllValues();

  final List<AttributeValue> resistanceValues;
  int get resistance => resistanceValues.sumAllValues();

  const Attributes(this.powerValues, this.abilityValues, this.resistanceValues);

  factory Attributes.baseAttributesPoints() {
    return Attributes(
      [AttributeValue.basePoint],
      [AttributeValue.basePoint],
      [AttributeValue.basePoint],
    );
  }
}

class AttributeValue {
  final int value;
  final String from;

  const AttributeValue(this.value, this.from);

  static const AttributeValue basePoint = AttributeValue(1, "Criação da ficha");
}

extension SumAttributesValues on List<AttributeValue> {
  int sumAllValues() => sumOf<int>((element) => element.value);
  List<AttributeValue> filterValuesFromPoints() =>
      where((element) => element.from == AttributeValue.basePoint.from).toList();
}
