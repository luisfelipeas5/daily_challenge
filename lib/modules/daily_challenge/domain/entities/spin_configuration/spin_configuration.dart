class SpinConfiguration {
  final int durationInMilliseconds;
  final int indexInitialOffset;

  SpinConfiguration({
    required this.durationInMilliseconds,
    required this.indexInitialOffset,
  });

  factory SpinConfiguration.empty() {
    return SpinConfiguration(
      durationInMilliseconds: 1,
      indexInitialOffset: 0,
    );
  }

  Duration get duration => Duration(milliseconds: durationInMilliseconds);
}
