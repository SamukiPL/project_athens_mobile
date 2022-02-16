class BackerModel {
  final String nickname;
  final int amount;
  final bool? hasBadge;
  final String? comment;
  final DateTime backedAt;
  final bool? isCurrentUser;

  BackerModel(this.nickname, this.amount, this.hasBadge, this.comment, this.backedAt, this.isCurrentUser);
}