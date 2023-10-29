import 'package:ficha_3det_victory/src/char_sheet/entities/char_sheet.dart';
import 'package:ficha_3det_victory/src/char_sheet/models/edit_char_sheet.dart';
import 'package:flutter/material.dart';

class CharSheetsListViewModel extends ChangeNotifier {
  final CharSheetsRepository repository;

  CharSheetsListViewModel(this.repository);

  bool _isLoading = true;
  bool _isLoaded = false;
  String _error = '';

  List<CharSheet> _charSheets = [];

  List<CharSheet> get charSheets => _charSheets;
  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;
  String get error => _error;

  bool get hasError => error.isNotEmpty;

  Future<void> fetchCharSheets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _charSheets = await repository.getAllCharSheets();
      _isLoaded = true;
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCharSheets(List<int> ids) async {
    _isLoading = true;
    notifyListeners();

    try {
      repository.deleteCharSheets(ids);

      _charSheets.removeWhere((element) => ids.contains(element.id));
      _isLoaded = true;
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
