import 'package:flutter/material.dart';
import 'package:word_walls/views/my_app_bar.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBar(), body: child);
  }
}
