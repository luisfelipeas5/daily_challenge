class SpinConfiguration {
  final int durationInMilliseconds;
  final int indexMultiplier;
  final int indexInitialOffset;

  SpinConfiguration({
    required this.durationInMilliseconds,
    required this.indexMultiplier,
    required this.indexInitialOffset,
  });

  factory SpinConfiguration.empty() {
    return SpinConfiguration(
      durationInMilliseconds: 1,
      indexMultiplier: 1,
      indexInitialOffset: 0,
    );
  }

  Duration get duration => Duration(milliseconds: durationInMilliseconds);
}
