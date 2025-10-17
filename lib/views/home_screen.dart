import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../listeners/ui_preferences_listener.dart';
import '../notifiers/ui_preferences.dart';
import '../goto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Walls"),
        centerTitle: true,
        actionsPadding: EdgeInsetsDirectional.only(start: 8),
        actions: [
          ShadButton.ghost(
            onPressed: uiPreferencesManager.notifier.nextThemeMode,
            leading: UiPreferencesListener(
              builder: (context, uiPreferences) {
                final themeMode = uiPreferences.themeMode;
                return Icon(
                  switch (themeMode) {
                    ThemeMode.system => LucideIcons.sunMoon,
                    ThemeMode.light => LucideIcons.sun,
                    ThemeMode.dark => LucideIcons.moon,
                  },

                  semanticLabel: switch (themeMode) {
                    ThemeMode.system => 'Switch to light mode',
                    ThemeMode.light => 'Switch to dark mode',
                    ThemeMode.dark => 'Switch to system defaut',
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: ShadButton.outline(
          onPressed: () => GoTo.userParameter(context),
          child: Text("Create new Wall"),
        ),
      ),
    );
  }
}
