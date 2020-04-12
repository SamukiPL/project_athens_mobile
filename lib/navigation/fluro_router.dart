import 'package:authorization_flow/login_widget.dart';
import 'package:fluro/fluro.dart';
import 'package:project_athens/presentation/main_widget.dart';

class RoutePaths {
  static String home = "home";

  static String login = "login";
}

extension FluroRouter on Router {
  Router createRouter() {
    var router = Router();

    Handler loginHandler = Handler(
        handlerFunc: (context, params) =>
            LoginWidget());
    Handler homeHandler =
    Handler(handlerFunc: (context, params) => MainWidget());

    router.define(RoutePaths.login, handler: loginHandler);
    router.define(RoutePaths.home, handler: homeHandler);

    return router;
  }
}