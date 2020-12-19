import 'package:flutter/cupertino.dart';

abstract class NounCloudState {}

class CloudLoading extends NounCloudState {

}

class CloudReady extends NounCloudState {

  final List<Widget> nounsWidgets;

  CloudReady(this.nounsWidgets);

}

class CloudFail extends NounCloudState {

}
