import 'package:flutter/material.dart';
import 'package:minimal_mvn/minimal_mvn.dart';
import 'package:word_walls/models/ui_preferences.dart';

extension ThemeModeExt on ThemeMode {
  ThemeMode get next => switch (this) {
    ThemeMode.system => ThemeMode.light,
    ThemeMode.light => ThemeMode.dark,
    ThemeMode.dark => ThemeMode.system,
  };
}

class UiPreferencesNotifier extends MMNotifier<UiPreferences> {
  UiPreferencesNotifier() : super(UiPreferences());

  void nextThemeMode() {
    final nextThemMode = state.themeMode.next;
    notify(state.copyWith(themeMode: nextThemMode));
  }
}

final MMManager<UiPreferencesNotifier> uiPreferencesManager = MMManager(
  UiPreferencesNotifier.new,
);
