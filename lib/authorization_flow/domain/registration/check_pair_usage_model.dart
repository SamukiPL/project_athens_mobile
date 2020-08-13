class CheckPairUsageModel {
  final bool loginTaken;
  final bool emailTaken;

  CheckPairUsageModel({this.loginTaken, this.emailTaken});

  bool get isSomethingTaken => loginTaken || emailTaken;
}