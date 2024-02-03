import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String charAlignment(String alignment) {
    String _temp0 = intl.Intl.selectLogic(
      alignment,
      {
        'Neutral': 'Neutral',
        'NeutralGood': 'Neutral Good',
        'NeutralEvil': 'Neutral Evil',
        'LawfulNeutral': 'Lawful Neutral',
        'LawfulGood': 'Lawful Good',
        'LawfulEvil': 'Lawful Evil',
        'ChaoticNeutral': 'ChaoticNeutral',
        'ChaoticGood': 'Chaotic Good',
        'ChaoticEvil': 'Chaotic Evil',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get charAttr_attributes => 'Attributes';

  @override
  String get charAttr_lore => 'Lore';

  @override
  String get charAttr_name => 'Name';

  @override
  String get charAttr_points => 'Points';

  @override
  String get charAttr_resources => 'Resources';

  @override
  String get home_appTitle => '3DeT Victory Character Sheet';

  @override
  String get home_campaignsTitle => 'Campaigns';

  @override
  String get home_characters => 'Characters';

  @override
  String get home_newChar => 'New';

  @override
  String get newCharConcept_changePhoto => 'Change picture';

  @override
  String get newCharConcept_PageName => 'Concept';

  @override
  String get newCharConcept_emptyNameValidationMessage => 'You must name your character';

  @override
  String get newCharConcept_loreInputHint => 'John was raised on a distant realm...';

  @override
  String get newCharConcept_nameInputHint => 'John Smith';

  @override
  String get newCharPoints_PageName => 'Points';

  @override
  String get newCharTitle => 'New Character';

  @override
  String get splash_hello => 'Hello';
}
