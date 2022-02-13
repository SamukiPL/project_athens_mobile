import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/chopper/simple_dio_client.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_widget_bloc.dart';
import 'package:project_athens/athens_core/presentation/agreement/data/get_agreement_html_repository_impl.dart';
import 'package:project_athens/athens_core/presentation/agreement/domain/get_agreement_html_use_case.dart';
import 'package:project_athens/athens_core/presentation/agreement/network/agreement_html_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AgreementModule extends Module {
  AgreementModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final SimpleDioClient dio = Provider.of<SimpleDioClient>(context);

    final AgreementHtmlApi agreementHtmlApi = AgreementHtmlApi(dio.client);
    final GetAgreementHtmlRepositoryImpl repository = GetAgreementHtmlRepositoryImpl(agreementHtmlApi);
    final GetAgreementHtmlUseCase useCase = GetAgreementHtmlUseCase(repository);

    return [
      ChangeNotifierProvider<AgreementWidgetBloc>(
        create: (BuildContext context) => AgreementWidgetBloc(useCase),
      )
    ];
  }
}
