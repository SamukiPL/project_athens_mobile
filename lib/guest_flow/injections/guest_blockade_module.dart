import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/guest_flow/screens/guest_blockade_bloc.dart';
import 'package:provider/provider.dart';

class GuestBlockadeModule extends Module {
  GuestBlockadeModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<GuestBlockadeBloc>(
        create: (_) => GuestBlockadeBloc(),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }
}
