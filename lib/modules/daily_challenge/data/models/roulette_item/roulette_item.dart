enum RouletteType {
  success,
  failed,
}

class RouletteItem {
  final RouletteType type;

  const RouletteItem({
    required this.type,
  });
}

extension RouletteTypeExtension on RouletteType {
  bool get isSuccess => this == RouletteType.success;
}
