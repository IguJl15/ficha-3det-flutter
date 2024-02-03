import 'package:ficha_3det_victory/src/char_sheet/entities/char_sheet.dart';

class Campaign {
  final String title;

  final List<CharSheet> chars;

  final List<String> annotations;

  Campaign({required this.title, required this.chars, required this.annotations});
}
