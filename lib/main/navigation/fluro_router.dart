import 'package:fluro/fluro.dart';
import 'package:project_athens/athens_core/chopper/network_module_simple.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/authorization_flow/login_widget.dart';
import 'package:project_athens/main/injections/app_navigation_module.dart';
import 'package:project_athens/main/presentation/main_widget.dart';

class RoutePaths {
  static String home = "home";

  static String login = "login";
}

extension FluroRouter on Router {
  Router createRouter() {
    var router = Router();

    Handler loginHandler = Handler(
        handlerFunc: (context, params) =>
            ModuleWidget(
              providers: [AppNavigationModule(context), LocalizationModule(context)],
              child: LoginWidget(),
            ));
    Handler homeHandler =
    Handler(handlerFunc: (context, params) => MainWidget());

    router.define(RoutePaths.login, handler: loginHandler);
    router.define(RoutePaths.home, handler: homeHandler);

    return router;
  }
}