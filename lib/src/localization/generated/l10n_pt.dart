import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String charAlignment(String alignment) {
    String _temp0 = intl.Intl.selectLogic(
      alignment,
      {
        'Neutral': 'Neutro',
        'NeutralGood': 'Neutro Bom',
        'NeutralEvil': 'Neutro Mal',
        'LawfulNeutral': 'Leal Neutro',
        'LawfulGood': 'Leal Bom',
        'LawfulEvil': 'Leal Mal',
        'ChaoticNeutral': 'Caótico Neutro',
        'ChaoticGood': 'Caótico Bom',
        'ChaoticEvil': 'Caótico Mal',
        'other': 'Desconhecido',
      },
    );
    return '$_temp0';
  }

  @override
  String get charAttr_attributes => 'Atributos';

  @override
  String get charAttr_lore => 'História';

  @override
  String get charAttr_name => 'Nome';

  @override
  String get charAttr_points => 'Pontos';

  @override
  String get charAttr_resources => 'Recursos';

  @override
  String get home_appTitle => 'Ficha de personagem 3DeT Victory';

  @override
  String get home_campaignsTitle => 'Campanhas';

  @override
  String get home_characters => 'Personagens';

  @override
  String get home_newChar => 'Novo';

  @override
  String get newCharConcept_changePhoto => 'Alterar imagem';

  @override
  String get newCharConcept_PageName => 'Conceito';

  @override
  String get newCharConcept_emptyNameValidationMessage => 'Escolha um nome';

  @override
  String get newCharConcept_loreInputHint => 'João nasceu em uma área remota ao sul...';

  @override
  String get newCharConcept_nameInputHint => 'João da Silva';

  @override
  String get newCharPoints_PageName => 'Pontos';

  @override
  String get newCharTitle => 'Novo Personagem';

  @override
  String get splash_hello => 'Olá';
}
