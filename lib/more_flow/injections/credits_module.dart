import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/more_flow/screens/credits/credits_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class CreditsModule extends Module {
  CreditsModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<CreditsBloc>(
        create: (_) => CreditsBloc(),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }
}
