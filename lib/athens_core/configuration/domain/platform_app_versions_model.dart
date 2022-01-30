import 'package:version/version.dart';

class PlatformAppVersionsModel {
  final Version iOS;
  final Version iPadOS;
  final Version android;

  const PlatformAppVersionsModel(this.iOS, this.iPadOS, this.android);
}
