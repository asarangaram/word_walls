import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../listeners/ui_preferences_listener.dart';
import '../goto.dart';
import 'home_screen.dart';

class WordWallsApp extends StatelessWidget {
  const WordWallsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPreferencesListener(
      builder: (context, uiPreferences) {
        return ShadApp(
          debugShowCheckedModeBanner: false,
          themeMode: uiPreferences.themeMode,
          routes: GoTo.routes,

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
