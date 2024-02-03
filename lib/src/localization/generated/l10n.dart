import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_pt.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// Char alignment set
  ///
  /// In pt, this message translates to:
  /// **'{alignment, select, Neutral{Neutro} NeutralGood{Neutro Bom} NeutralEvil{Neutro Mal} LawfulNeutral{Leal Neutro} LawfulGood{Leal Bom} LawfulEvil{Leal Mal} ChaoticNeutral{Caótico Neutro} ChaoticGood{Caótico Bom} ChaoticEvil{Caótico Mal} other{Desconhecido}}'**
  String charAlignment(String alignment);

  /// Name of the 'attributes' attribute on character sheet
  ///
  /// In pt, this message translates to:
  /// **'Atributos'**
  String get charAttr_attributes;

  /// Name of the 'lore' attribute on character sheet
  ///
  /// In pt, this message translates to:
  /// **'História'**
  String get charAttr_lore;

  /// Name of the 'name' attribute on character sheet
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get charAttr_name;

  /// Name of the 'points' attribute on character sheet
  ///
  /// In pt, this message translates to:
  /// **'Pontos'**
  String get charAttr_points;

  /// Name of the 'resources' attribute on character sheet
  ///
  /// In pt, this message translates to:
  /// **'Recursos'**
  String get charAttr_resources;

  /// The title of the application
  ///
  /// In pt, this message translates to:
  /// **'Ficha de personagem 3DeT Victory'**
  String get home_appTitle;

  /// Campaigns title
  ///
  /// In pt, this message translates to:
  /// **'Campanhas'**
  String get home_campaignsTitle;

  /// characters
  ///
  /// In pt, this message translates to:
  /// **'Personagens'**
  String get home_characters;

  /// Name displayed on primary button to create a new char
  ///
  /// In pt, this message translates to:
  /// **'Novo'**
  String get home_newChar;

  /// No description provided for @newCharConcept_changePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Alterar imagem'**
  String get newCharConcept_changePhoto;

  /// New char concept page name
  ///
  /// In pt, this message translates to:
  /// **'Conceito'**
  String get newCharConcept_PageName;

  /// New char concept Empty name validation message
  ///
  /// In pt, this message translates to:
  /// **'Escolha um nome'**
  String get newCharConcept_emptyNameValidationMessage;

  /// New char concept page lore input hint
  ///
  /// In pt, this message translates to:
  /// **'João nasceu em uma área remota ao sul...'**
  String get newCharConcept_loreInputHint;

  /// New char concept page name input hint
  ///
  /// In pt, this message translates to:
  /// **'João da Silva'**
  String get newCharConcept_nameInputHint;

  /// New char points page name
  ///
  /// In pt, this message translates to:
  /// **'Pontos'**
  String get newCharPoints_PageName;

  /// title that should appear on char creation page
  ///
  /// In pt, this message translates to:
  /// **'Novo Personagem'**
  String get newCharTitle;

  /// hello
  ///
  /// In pt, this message translates to:
  /// **'Olá'**
  String get splash_hello;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
