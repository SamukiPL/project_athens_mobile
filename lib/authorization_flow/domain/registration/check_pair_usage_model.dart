class CheckPairUsageModel {
  final bool loginTaken;
  final bool emailTaken;

  CheckPairUsageModel({required this.loginTaken, required this.emailTaken});

  bool get isSomethingTaken => loginTaken || emailTaken;
}