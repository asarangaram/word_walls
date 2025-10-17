import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:word_walls/listeners/nav_listener.dart';
import 'package:word_walls/listeners/ui_preferences_listener.dart';
import 'package:word_walls/notifiers/navigate.dart';
import 'package:word_walls/notifiers/ui_preferences.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavListener(
      builder: (context, page) {
        return AppBar(
          title: Text("Word Walls"),
          centerTitle: true,
          actionsPadding: EdgeInsetsDirectional.only(start: 8),
          leading: page != NavPage.home
              ? ShadButton.ghost(
                  leading: Icon(Icons.home),
                  onPressed: () {
                    navPagesManager.notifier.goto(NavPage.home);
                  },
                )
              : null,
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
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
