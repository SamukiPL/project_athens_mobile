import 'package:flutter/material.dart';
import 'package:project_athens/guest_flow/domain/logged_state.dart';

abstract class AppNavigation {

  void goToMainWidget(BuildContext context, {LoggedState loggedState});

  void goToLoginWidget(BuildContext context);

}