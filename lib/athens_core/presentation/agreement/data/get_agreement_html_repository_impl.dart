import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/agreement/domain/get_agreement_html_repository.dart';
import 'package:project_athens/athens_core/presentation/agreement/network/agreement_html_api.dart';

class GetAgreementHtmlRepositoryImpl implements GetAgreementHtmlRepository {
  final AgreementHtmlApi _agreementHtmlApi;

  GetAgreementHtmlRepositoryImpl(this._agreementHtmlApi);

  @override
  Future<Result<String>> getAgreementHtml(String agreementUrl) async {
    return _agreementHtmlApi
        .getAgreementHtml(agreementUrl)
        .then((value) => value.data != null
          ? Success(value.data!)
          : Failure(value.statusMessage)
    );
  }
}