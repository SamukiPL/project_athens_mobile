import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/guest_flow/data/guest_blockade_repository_impl.dart';
import 'package:project_athens/guest_flow/domain/logout_guest_use_case.dart';
import 'package:project_athens/guest_flow/screens/guest_blockade_bloc.dart';
import 'package:provider/provider.dart';

class GuestBlockadeModule extends Module {
  GuestBlockadeModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final authFacade = Provider.of<AuthFacade>(context);
    final repository = GuestBlockadeRepositoryImpl(authFacade);
    final logoutGuestUseCase = LogoutGuestUseCase(repository);

    return [
      Provider<GuestBlockadeBloc>(
        create: (_) => GuestBlockadeBloc(logoutGuestUseCase),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }
}
