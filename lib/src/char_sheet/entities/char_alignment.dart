enum CharAlignment {
  lawfulGood("LawfulGood"),
  neutralGood("NeutralGood"),
  chaoticGood("ChaoticGood"),
  lawfulNeutral("LawfulNeutral"),
  neutral("Neutral"),
  chaoticNeutral("ChaoticNeutral"),
  lawfulEvil("LawfulEvil"),
  neutralEvil("NeutralEvil"),
  chaoticEvi("ChaoticEvi");

  const CharAlignment(this.localizationString);

  final String localizationString;

  static CharAlignment tryParse(String value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => CharAlignment.neutral,
    );
  }
}
