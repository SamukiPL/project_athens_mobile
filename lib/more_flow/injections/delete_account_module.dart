import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/more_flow/data/more/delete_account_repository_impl.dart';
import 'package:project_athens/more_flow/data/network/more_api.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_use_case.dart';
import 'package:project_athens/more_flow/screens/delete_account/delete_account_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DeleteAccountModule extends Module {
  DeleteAccountModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = Provider.of<Dio>(context);
    final moreApi = MoreApi(client);
    final _deleteAccountRepository = DeleteAccountRepositoryImpl(moreApi);
    final _deleteAccountUseCase = DeleteAccountUseCase(_deleteAccountRepository);

    return [
      Provider<DeleteAccountBloc>(
          create: (_) => DeleteAccountBloc(_deleteAccountUseCase),
          dispose: (context, bloc) => bloc.dispose()),
    ];
  }
}
