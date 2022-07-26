enum RoulettePageStatus {
  idle,
  spinning,
  success,
  failed,
}

extension RoulettePageStatusExtension on RoulettePageStatus {
  bool isIdle() => this == RoulettePageStatus.idle;

  bool isSpinning() => this == RoulettePageStatus.spinning;

  bool isSuccess() => this == RoulettePageStatus.success;

  bool isFailed() => this == RoulettePageStatus.failed;
}
