class DeleteAccountParams {
  final String reason;
  final String? additionalNotes;
  final String? deviceInfo;

  DeleteAccountParams(this.reason, this.additionalNotes, this.deviceInfo);
}
