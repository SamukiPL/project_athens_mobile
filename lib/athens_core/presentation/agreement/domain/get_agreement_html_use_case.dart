import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/agreement/domain/agreement_html_params.dart';
import 'package:project_athens/athens_core/presentation/agreement/domain/get_agreement_html_repository.dart';

class GetAgreementHtmlUseCase extends BaseUseCase {
  final GetAgreementHtmlRepository _repository;

  GetAgreementHtmlUseCase(this._repository);

  Future<Result<String>> call(AgreementHtmlParams params) {
    return _repository.getAgreementHtml(params.agreementUrl);
  }
}
