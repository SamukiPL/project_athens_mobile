import 'package:flutter/widgets.dart' hide Router;
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:fluro/fluro.dart';

import 'fluro_router.dart';

class AppNavigationImpl implements AppNavigation {

  final Router router;

  AppNavigationImpl(this.router);

  @override
  void goToLoginWidget(BuildContext context) {
    router.navigateTo(context, RoutePaths.login,
        transition: TransitionType.material, replace: true, clearStack: true);
  }

  @override
  void goToMainWidget(BuildContext context) {
    router.navigateTo(context, RoutePaths.home,
        transition: TransitionType.material, replace: true, clearStack: true);
  }

}