import 'package:flutter/material.dart';
import 'package:word_walls/models/ui_preferences.dart';
import 'package:word_walls/notifiers/ui_preferences.dart';

class UiPreferencesListener extends StatelessWidget {
  const UiPreferencesListener({super.key, required this.builder});
  final Widget Function(BuildContext context, UiPreferences preferences)
  builder;

  @override
  Widget build(BuildContext context) {
    final notifier = uiPreferencesManager.notifier;
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, final __) {
        return builder(context, notifier.state);
      },
    );
  }
}
