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
