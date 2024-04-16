import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteSoundsProvider with ChangeNotifier {
  List<String> _favoriteSounds = [];

  List<String> get favoriteSounds => _favoriteSounds;

  void addSound(String sound) {
    _favoriteSounds.add(sound);
    notifyListeners();
    _saveToPrefs();
  }

  void removeSound(String sound) {
    _favoriteSounds.remove(sound);
    notifyListeners();
    _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteSounds', _favoriteSounds);
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteSounds = prefs.getStringList('favoriteSounds') ?? [];
    notifyListeners();
  }
}
