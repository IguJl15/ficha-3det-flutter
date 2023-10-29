import '../../shared/extensions/list_extensions.dart';
import '../../shared/extensions/num_extensions.dart';
import 'advantage.dart';
import 'attributes.dart';
import 'char_alignment.dart';
import 'resources.dart';
import 'skill.dart';

final class CharSheet {
  int id;
  String name;
  String lore;

  String? profilePhotoUrl;

  int points;

  Attributes attributes;
  Resources resources;

  List<Advantage> advantages;

  /// All disadvantage has negative points
  List<Advantage> disadvantages;

  CharAlignment alignment;
  List<Skill> skills;

  int get pointsSpent {
    int sum = 0;

    sum += pointsSpentOnAdvantages;
    sum -= pointsEarnedOnDisadvantages;
    sum += pointsSpentOnSkills;
    sum += pointsUsedOnAttributes;

    return sum;
  }

  int get pointsSpentOnAdvantages => advantages.sumOf((adv) => adv.points);
  int get pointsEarnedOnDisadvantages => disadvantages.sumOf((adv) => adv.points);
  int get pointsSpentOnSkills => skills.length;
  int get pointsUsedOnAttributes {
    return <AttributeValue>[
      ...attributes.powerValues,
      ...attributes.abilityValues,
      ...attributes.resistanceValues,
    ] //
        .filterValuesFromPoints()
        .sumAllValues()
        .minus(3)
        .toInt();
  }

  CharSheet({
    required this.id,
    required this.name,
    required this.lore,
    this.profilePhotoUrl,
    this.points = 10,
    required this.attributes,
    required this.resources,
    required this.advantages,
    required this.disadvantages,
    required this.alignment,
    required this.skills,
  });

  factory CharSheet.empty() {
    final attributes = Attributes.baseAttributesPoints();
    return CharSheet(
      id: -1,
      name: "",
      lore: "",
      profilePhotoUrl: null,
      attributes: attributes,
      resources: Resources.fromAttributes(attributes),
      advantages: [],
      disadvantages: [],
      alignment: CharAlignment.neutral,
      skills: [],
    );
  }

  bool hasAdvantage(Advantage advantage) => advantages.any((adv) => adv.name == advantage.name);

  void removeAdvantage(Advantage advantage) {
    advantages.removeWhere((adv) => adv.name == advantage.name);
  }

  void addAdvantage(Advantage advantage) {
    advantages.add(advantage);
  }

  void updateAdvantage(Advantage advantage) {
    // found first with same name
    final foundIndex = advantages.indexWhere((e) => e.name == advantage.name);

    if (foundIndex >= 0) {
      advantages[foundIndex] = advantage;
    }
  }

  Advantage getAdvantage(String name) {
    return advantages.singleWhere((adv) => adv.name == name);
  }
}
