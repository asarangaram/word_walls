import 'package:flutter/material.dart';
import 'package:word_walls/listeners/nav_listener.dart';
import 'package:word_walls/notifiers/navigate.dart';
import 'package:word_walls/views/page_home.dart';
import 'package:word_walls/views/page_pref.dart';

class NavPageView extends StatelessWidget {
  const NavPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavListener(
      builder: (context, navPage) {
        return switch (navPage) {
          NavPage.home => HomePage(),
          NavPage.pref => PrefPage(),
        };
      },
    );
  }
}
