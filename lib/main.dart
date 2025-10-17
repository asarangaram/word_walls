import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:word_walls/listeners/ui_preferences_listener.dart';

import 'notifiers/ui_preferences.dart';
import 'user_parameters.dart';

void main() {
  SolidartConfig.devToolsEnabled = false;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      '/userParameter': (_) => const UserParameters(),
    };
    return UiPreferencesListener(
      builder: (context, uiPreferences) {
        return ShadApp(
          debugShowCheckedModeBanner: false,
          themeMode: uiPreferences.themeMode,
          routes: routes,
          theme: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: const ShadZincColorScheme.light(),
            textTheme: ShadTextTheme(
              custom: {
                'myCustomStyle': const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              },
            ),
          ),
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: const ShadZincColorScheme.dark(),
            textTheme: ShadTextTheme(
              custom: {
                'myCustomStyle': const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                ),
              },
            ),
          ),
          home: const HomeScreen(),
          builder: (context, child) {
            return child!;
          },
        );
      },
    );
  }
}

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
    );
  }
}
