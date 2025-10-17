import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:word_walls/listeners/ui_preferences_listener.dart';
import 'package:word_walls/views/nav_page_view.dart';
import 'package:word_walls/views/page_pref.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      '/userParameter': (_) => const PrefPage(),
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
          home: const NavPageView(),
          builder: (context, child) {
            return child!;
          },
        );
      },
    );
  }
}
