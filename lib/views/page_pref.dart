import 'package:flutter/material.dart';
import 'package:word_walls/views/my_scaffold.dart';

import 'my_app_bar.dart';

class PrefPage extends StatelessWidget {
  const PrefPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(child: Center(child: Text("Hello")));
  }
}
