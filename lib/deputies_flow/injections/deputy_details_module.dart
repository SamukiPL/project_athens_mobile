import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_bloc.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:provider/provider.dart';

class DeputyDetailsModule extends Module {

  final DeputyModel _deputyModel;

  DeputyDetailsModule(BuildContext context, this._deputyModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<DeputyDetailsBloc>(
        create: (context) => DeputyDetailsBloc(_deputyModel),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}