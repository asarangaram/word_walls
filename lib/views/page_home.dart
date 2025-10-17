import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:word_walls/notifiers/navigate.dart';

import 'my_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Center(
        child: ShadButton.secondary(
          child: Text("New Wall"),
          onPressed: () {
            navPagesManager.notifier.goto(NavPage.pref);
          },
        ),
      ),
    );
  }
}
