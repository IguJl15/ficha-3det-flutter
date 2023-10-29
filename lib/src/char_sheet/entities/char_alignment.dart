enum CharAlignment {
  lawfulGood("Leal Bom"),
  neutralGood("Neutro Bom"),
  chaoticGood("Caótico Bom"),
  lawfulNeutral("Leal Neutro"),
  neutral("Neutro"),
  chaoticNeutral("Caótico Neutro"),
  lawfulEvil("Leal Mal"),
  neutralEvil("Neutro Mal"),
  chaoticEvi("Caótico Mal");

  const CharAlignment(this.verbose);

  final String verbose;

  static CharAlignment tryParse(String value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => CharAlignment.neutral,
    );
  }
}
