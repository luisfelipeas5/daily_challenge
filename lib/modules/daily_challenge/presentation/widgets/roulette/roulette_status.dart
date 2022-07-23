enum RouletteStatus {
  idle,
  spinning,
}

extension RouletteStatusExtensions on RouletteStatus {
  bool get idle => this == RouletteStatus.idle;

  bool get spinning => this == RouletteStatus.spinning;
}
