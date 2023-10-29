import '../entities/resources.dart';

import '../entities/advantage.dart';
import '../entities/attributes.dart';
import '../entities/char_alignment.dart';
import '../entities/char_sheet.dart';
import '../entities/skill.dart';
import 'package:flutter/material.dart';

abstract interface class CharSheetsRepository {
  List<Advantage> getAllAvailableAdvantages();
  List<Advantage> getAllAvailableDisadvantages();
  List<Skill> getAllAvailableSkills();

  List<CharSheet> getAllCharSheets();

  /// Save char
  void createChar(CharSheet charSheet);
  void deleteCharSheets(List<int> id);
}

enum CharAttribute { power, ability, resistance }

class CreateCharViewModel extends ChangeNotifier {
  final CharSheetsRepository repository;

  final CharSheet _charSheet;

  CharSheet get state => _charSheet;

  CreateCharViewModel(this.repository, [CharSheet? charSheet]) : _charSheet = charSheet ?? CharSheet.empty();

  void setName(String name) {
    _charSheet.name = name;
    notifyListeners();
  }

  void setLore(String name) {
    _charSheet.lore = name;
    notifyListeners();
  }

  void setAlignment(CharAlignment alignment) {
    _charSheet.alignment = alignment;
    notifyListeners();
  }

  void toggleSkill(Skill skill) {
    if (_charSheet.skills.contains(skill)) {
      _charSheet.skills.remove(skill);
    } else {
      _charSheet.skills.add(skill);
    }
    notifyListeners();
  }

  _recalculateResources() {
    _charSheet.resources = Resources.fromAttributes(_charSheet.attributes);
  }

  void incrementAttribute(CharAttribute attribute) {
    switch (attribute) {
      case CharAttribute.power:
        _charSheet.attributes.powerValues.add(AttributeValue.basePoint);
      case CharAttribute.ability:
        _charSheet.attributes.abilityValues.add(AttributeValue.basePoint);
      case CharAttribute.resistance:
        _charSheet.attributes.resistanceValues.add(AttributeValue.basePoint);
    }

    _recalculateResources();

    notifyListeners();
  }

  void decrementAttribute(CharAttribute attribute) {
    switch (attribute) {
      case CharAttribute.power:
        if (_charSheet.attributes.powerValues.filterValuesFromPoints().isNotEmpty) {
          _charSheet.attributes.powerValues.remove(AttributeValue.basePoint);
        }
      case CharAttribute.ability:
        if (_charSheet.attributes.abilityValues.filterValuesFromPoints().isNotEmpty) {
          _charSheet.attributes.abilityValues.remove(AttributeValue.basePoint);
        }
      case CharAttribute.resistance:
        if (_charSheet.attributes.resistanceValues.filterValuesFromPoints().isNotEmpty) {
          _charSheet.attributes.resistanceValues.remove(AttributeValue.basePoint);
        }
    }

    _recalculateResources();

    notifyListeners();
  }

  void toggleAdvantage(Advantage advantage) {
    if (_charSheet.hasAdvantage(advantage)) {
      _charSheet.removeAdvantage(advantage);
    } else {
      _charSheet.addAdvantage(advantage);
    }
    notifyListeners();
  }

  void incrementAdvantage(AmplifyingAdvantage advantage) {
    if (_charSheet.hasAdvantage(advantage)) {
      final charAdv = _charSheet.getAdvantage(advantage.name) as AmplifyingAdvantage;
      final updatedAdvantage = charAdv.incrementedByOne();

      _charSheet.updateAdvantage(updatedAdvantage);
    } else {
      _charSheet.addAdvantage(advantage.incrementedByOne());
    }

    notifyListeners();
  }

  void decrementAdvantage(AmplifyingAdvantage advantage) {
    if (_charSheet.hasAdvantage(advantage)) {
      final charAdv = _charSheet.getAdvantage(advantage.name) as AmplifyingAdvantage;
      final updatedAdvantage = charAdv.decrementedByOne();

      if (updatedAdvantage.amount > 0) {
        _charSheet.updateAdvantage(updatedAdvantage);
      } else {
        _charSheet.removeAdvantage(advantage);
      }

      notifyListeners();
    }
  }

  List<Advantage> getAllAdvantagesAvailable() {
    return repository.getAllAvailableAdvantages();
  }

  List<Advantage> getAllDisadvantagesAvailable() {
    return repository.getAllAvailableDisadvantages();
  }

  List<Skill> getAllSkillsAvailable() {
    return repository.getAllAvailableSkills();
  }

  bool finishCharCreation() {
    repository.createChar(_charSheet);

    return true;
  }

  void setImageUrl(String? path) {
    _charSheet.profilePhotoUrl = path;

    notifyListeners();
  }
}
