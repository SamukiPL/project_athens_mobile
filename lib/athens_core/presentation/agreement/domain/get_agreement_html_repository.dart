import 'package:project_athens/athens_core/domain/result.dart';

abstract class GetAgreementHtmlRepository {
  Future<Result<String>> getAgreementHtml(String agreementUrl);
}