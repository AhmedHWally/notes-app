import 'package:flutter/material.dart';
import 'package:last_note_app/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (!L10n.all.contains(locale)) return;
    if (locale == const Locale('en')) {
      prefs.setString('lang', 'en');
      _locale = locale;
      notifyListeners();
    }
    if (locale == const Locale('ar')) {
      prefs.setString('lang', 'ar');
      _locale = locale;
      notifyListeners();
    }
  }

  Future<Locale> get getLocale async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lang') == 'ar') {
      return const Locale('ar');
    }
    return const Locale('en');
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
