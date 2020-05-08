import 'package:athens_core/injections/module.dart';
import 'package:athens_core/navigation/app_navigation.dart';
import 'package:athens_core/presentation/fab/base_fab.dart';
import 'package:athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:authorization_flow/injections/deputies_registration_module.dart';
import 'package:authorization_flow/screens/base_login_screen.dart';
import 'package:authorization_flow/screens/deputies_registration/deputies_registration_bloc.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputies_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeputiesRegistrationScreen extends BaseLoginScreen<DeputiesRegistrationBloc> {

  @override
  List<Module> getProviders(BuildContext context) {
    return [DeputiesRegistrationModule(context)];
  }

  @override
  Widget generateAppBar(BuildContext context, DeputiesRegistrationBloc bloc) {
    return SearchAppBar(
        title: "Subscribe",
        hintText: "Search...",
        showBackArrow: false,
        searchQuery: (searchQuery) => {bloc.setSearchQuery(searchQuery)},
        additionalIcons: [IconButton(icon: Icon(Icons.forward), onPressed: () {},)]
    );
  }

  @override
  Widget generateBody(BuildContext context, DeputiesRegistrationBloc bloc) {
    return DeputiesList(bloc.adapter);
  }

  @override
  Widget generateFab(BuildContext context, DeputiesRegistrationBloc bloc) {
    return BaseFab(
      onPressed: () { bloc.onFabPressed(); },
      bloc: bloc.fabBloc,
      child: Icon(Icons.done),
    );
  }

  @override
  void onAuthFailure() {
    // TODO: implement onAuthFailure
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToMainWidget(context);
  }
}