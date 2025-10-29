import 'package:minimal_mvn/minimal_mvn.dart';

enum NavPage { home, pref, test }

class NavPagesNotifier extends MMNotifier<NavPage> {
  NavPagesNotifier() : super(NavPage.test);

  void goto(NavPage page) => notify(page);
}

final MMManager<NavPagesNotifier> navPagesManager = MMManager(
  NavPagesNotifier.new,
);
