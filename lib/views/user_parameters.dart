import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../goto.dart';

class UserParameters extends StatelessWidget {
  const UserParameters({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShadButton.outline(
        onPressed: () => GoTo.prev(context),
        child: Text("Done"),
      ),
    );
  }
}
