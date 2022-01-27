import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreementBloc extends BaseChangeNotifier with ConfigurationDelegate<DateTime, DateTime> {
  static const String agreementUrl = 'https://swiadoma-demokracja.pl/swiadoma-demokracja-app-terms-agreement.html';
  static const String fallbackUrl = 'TODO?';

  final Dio dio;
  final ScrollController _scrollController = ScrollController();
  final BehaviorSubject<double> _scrollProgressSource = BehaviorSubject.seeded(0.0);

  @override
  DateTime? get defaultStorageValue => null;

  @override
  String get preferenceName => ConfigurationStorageNames.LAST_PRIVACY_POLICY_VERSION;

  double _downloadProgress = 0.0;
  String? _htmlContent;
  bool hasReachedEnd = false;

  double get downloadProgress => _downloadProgress;
  String? get html => _htmlContent;
  bool get isLoaded => _htmlContent != null;
  ScrollController get scrollController => _scrollController;
  Stream<double> get scrollProgressStream => _scrollProgressSource.stream;

  AgreementBloc(this.dio) {
    _fetchPDF();
    _listenOnScrollPosChange();
  }

  Future<void> tryToLaunchInBrowser() {
    return launch(AgreementBloc.agreementUrl);
  }

  void _fetchPDF() async {
    final Response<dynamic> response = await dio
        .get(
        AgreementBloc.agreementUrl,
        onReceiveProgress: (rcv, total) {
          _downloadProgress = ((rcv / total) * 100);
          notifyListeners();
        } ,
        options: Options(contentType: 'text/html')
    );

    _htmlContent = response.data as String;
    notifyListeners();
  }

  void _listenOnScrollPosChange() {
    _scrollController.addListener(() {
      _scrollProgressSource.add(_scrollController.position.pixels / _scrollController.position.maxScrollExtent);

      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if (hasReachedEnd == false) {
          hasReachedEnd = true;
          notifyListeners();
        }
      }
    });
  }

  Future<void> updatePolicyVersion() async {
    await updatePreference(DateTime.now());
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }


}