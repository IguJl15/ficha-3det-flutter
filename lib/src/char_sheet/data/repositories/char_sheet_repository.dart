import 'dart:convert';

import '../../entities/char_alignment.dart';
import '../../entities/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/advantage.dart';
import '../../entities/attributes.dart';
import '../../entities/char_sheet.dart';
import '../../entities/skill.dart';
import '../../models/edit_char_sheet.dart';
import '../standard_data/advantages.dart';
import '../standard_data/disadvantages.dart';
import '../standard_data/skills.dart';

typedef Json = Map<String, dynamic>;

class LocalCharSheetsRepository implements CharSheetsRepository {
  final SharedPreferences _preferences;

  LocalCharSheetsRepository(this._preferences);

  @override
  List<Advantage> getAllAvailableAdvantages() {
    return DefaultAdvantages.defaultAdvantages.toList();

    // final advantagesJson = _preferences.getString('custom_advantages');

    // if (advantagesJson == null) {
    //   return defaultAdvantages;
    // }

    // final advantages = jsonDecode(advantagesJson) as List<Json>;
    // return defaultAdvantages + advantages.map((advantage) => AdvantageJson.fromJson(advantage)).toList();
  }

  @override
  List<Advantage> getAllAvailableDisadvantages() {
    return DefaultDisadvantages.defaultDisadvantages.toList();

    // final disadvantagesJson = _preferences.getString('disadvantages');

    // if (disadvantagesJson == null) {
    //   return defaultDisadvantages;
    // }

    // final disadvantages = jsonDecode(disadvantagesJson) as List<Json>;
    // return defaultDisadvantages + disadvantages.map((disadvantage) => AdvantageJson.fromJson(disadvantage)).toList();
  }

  @override
  List<Skill> getAllAvailableSkills() {
    return DefaultSkills.defaultSkillsSet;
  }

  @override
  List<CharSheet> getAllCharSheets() {
    final charSheetsJson = _preferences.getString('charSheets');

    final List charSheets = charSheetsJson != null ? jsonDecode(charSheetsJson) : [];

    return charSheets.map((e) => _CharSheetJson.fromMap(e)).toList();
  }

  @override
  void createChar(CharSheet charSheet) {
    final charSheetsJson = _preferences.getString('charSheets');

    final List savedCharSheets = charSheetsJson != null ? jsonDecode(charSheetsJson) : [];

    if (charSheet.id >= 0) {
      savedCharSheets.removeWhere((element) => element["id"] == charSheet.id);
    } else {
      charSheet.id = (savedCharSheets.lastOrNull?["id"] as int?) ?? 0;
    }

    savedCharSheets.add(charSheet.toMap());

    final charSheetsJsonUpdated = jsonEncode(savedCharSheets);

    _preferences.setString('charSheets', charSheetsJsonUpdated);
  }

  @override
  void deleteCharSheets(List<int> ids) {
    final charSheetsJson = _preferences.getString('charSheets');

    final List savedCharSheets = charSheetsJson != null ? jsonDecode(charSheetsJson) : [];

    savedCharSheets.removeWhere((element) => ids.contains(element["id"]));

    final charSheetsJsonUpdated = jsonEncode(savedCharSheets);

    _preferences.setString('charSheets', charSheetsJsonUpdated);
  }
}

extension _CharSheetJson on CharSheet {
  Json toMap() => {
        "id": id,
        "name": name,
        "lore": lore,
        "profilePhotoUrl": profilePhotoUrl,
        "points": points,
        "attributes": attributes.toMap(),
        "advantages": advantages.map((e) => e.name.toString()).toList(),
        "disadvantages": disadvantages.map((e) => e.name.toString()).toList(),
        "skills": skills.map((e) => e.toMap()).toList(),
        "alignment": alignment.name,
      };

  static CharSheet fromMap(Json map) {
    final attributes = _AttributesJson.fromMap(map["attributes"]);
    return CharSheet(
      id: map["id"],
      name: map["name"],
      lore: map["lore"],
      points: map["points"],
      profilePhotoUrl: map["profilePhotoUrl"],
      attributes: attributes,
      resources: Resources.fromAttributes(attributes),
      advantages: DefaultAdvantages.defaultAdvantages
          .where((element) => (map["advantages"] as List).contains(element.name))
          .toList(),
      disadvantages: DefaultAdvantages.defaultAdvantages
          .where((element) => (map["advantages"] as List).contains(element.name))
          .toList(),
      alignment: CharAlignment.tryParse(map["alignment"]),
      skills: (map["skills"] as List).map((e) => _SkillsJson.fromMap(e)).toList(),
    );
  }
}

extension _AttributesJson on Attributes {
  Json toMap() => {
        "power": powerValues.map((e) => {"value": e.value, "from": e.from}).toList(),
        "ability": abilityValues.map((e) => {"value": e.value, "from": e.from}).toList(),
        "resistance": resistanceValues.map((e) => {"value": e.value, "from": e.from}).toList(),
      };

  static Attributes fromMap(Json map) {
    return Attributes(
      (map["power"] as List).map((e) => AttributeValue(e["value"], e["from"])).toList(),
      (map["ability"] as List).map((e) => AttributeValue(e["value"], e["from"])).toList(),
      (map["resistance"] as List).map((e) => AttributeValue(e["value"], e["from"])).toList(),
    );
  }
}

extension _SkillsJson on Skill {
  Json toMap() => {
        "id": id,
        "title": title,
        "description": description,
      };

  static Skill fromMap(Json map) {
    return Skill(map["title"], map["description"]);
  }
}


// extension AdvantageJson on Advantage {
//   static Advantage fromJson(Json json, [MultipleAdvantages? parent]) {
//     final id = int.parse(json["id"].toString());
//     final name = json["name"];
//     final description = json["description"];
//     final cost = int.parse(json["cost"].toString());

//     final String discriminator = json["discriminator"];

//     return switch (discriminator) {
//       "Advantage" => Advantage(name, description, cost, id, parent),
//       "AmplifyingAdvantage" => AmplifyingAdvantage(name, description, cost, int.parse(json["amount"]), id, parent),
//       _ => throw FormatException("Discriminator ($discriminator) is not valid")
//     };
//   }

//   Json toMap() => {
//         "discriminator": runtimeType.toString(),
//         "id": id,
//         "name": name,
//         "description": description,
//         "cost": cost,
//         "parentId": parent?.id,
//         if (this is AmplifyingAdvantage) ...{
//           "amount": this.amount,
//         },
//       };
//   static String toJson() {}
// }