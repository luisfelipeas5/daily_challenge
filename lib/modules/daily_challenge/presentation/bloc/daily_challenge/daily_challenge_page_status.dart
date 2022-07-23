enum DailyChallengePageStatus {
  idle,
  spinning,
  success,
  failed,
}

extension DailyChallengePageStatusExtension on DailyChallengePageStatus {
  bool isIdle() => this == DailyChallengePageStatus.idle;

  bool isSpinning() => this == DailyChallengePageStatus.spinning;

  bool isSuccess() => this == DailyChallengePageStatus.success;

  bool isFailed() => this == DailyChallengePageStatus.failed;
}
