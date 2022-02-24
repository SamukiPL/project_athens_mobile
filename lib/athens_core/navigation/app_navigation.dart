import 'package:flutter/material.dart';

abstract class AppNavigation {

  void goToMainWidget(BuildContext context, {bool isLogged});

  void goToLoginWidget(BuildContext context);

}