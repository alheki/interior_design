import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences _prefs;

  SettingsCubit(this._prefs) : super(const SettingsState());

  void loadSettings() {
    final themeMode = _getThemeMode();
    final locale = _getLocale();
    emit(state.copyWith(themeMode: themeMode, locale: locale));
  }

  void changeTheme(ThemeMode themeMode) {
    _prefs.setString('theme_mode', themeMode.name);
    emit(state.copyWith(themeMode: themeMode));
  }

  void changeLanguage(Locale locale) {
    _prefs.setString('language_code', locale.languageCode);
    _prefs.setString('country_code', locale.countryCode ?? '');
    emit(state.copyWith(locale: locale));
  }

  ThemeMode _getThemeMode() {
    final themeName = _prefs.getString('theme_mode');
    switch (themeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Locale _getLocale() {
    final languageCode = _prefs.getString('language_code') ?? 'en';
    final countryCode = _prefs.getString('country_code') ?? '';
    return Locale(languageCode, countryCode.isEmpty ? null : countryCode);
  }
}