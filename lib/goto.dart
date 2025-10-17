import 'package:flutter/material.dart';

import 'views/user_parameters.dart';
import 'views/home_screen.dart';

class GoTo {
  static void home(BuildContext context) {
    Navigator.of(context).pushNamed('/home');
  }

  static void userParameter(BuildContext context) {
    Navigator.of(context).pushNamed('/userParameter');
  }

  static void prev<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static final routes = <String, WidgetBuilder>{
    '/home': (context) => const HomeScreen(),
    '/userParameter': (context) => const UserParameters(),
  };
}
