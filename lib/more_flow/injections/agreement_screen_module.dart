import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/more_flow/screens/agreement/agreement_screen_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AgreementScreenModule extends Module {
  AgreementScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<AgreementScreenBloc>(
        create: (context) => AgreementScreenBloc(),
        dispose: (context, bloc) => bloc.dispose(),
      ),
    ];
  }
}
