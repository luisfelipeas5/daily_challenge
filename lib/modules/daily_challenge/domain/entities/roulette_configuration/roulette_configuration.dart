import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/spin_configuration/spin_configuration.dart';

typedef RoulettePattern = List<int>;

class RouletteConfiguration {
  final RoulettePattern pattern;
  final SpinConfiguration spinConfiguration;
  final SpinConfiguration specialSpinConfiguration;

  const RouletteConfiguration({
    required this.pattern,
    required this.spinConfiguration,
    required this.specialSpinConfiguration,
  });

  factory RouletteConfiguration.empty() {
    return RouletteConfiguration(
      pattern: [0],
      spinConfiguration: SpinConfiguration.empty(),
      specialSpinConfiguration: SpinConfiguration.empty(),
    );
  }

  List<RouletteItem> get rouletteItems {
    return pattern
        .asMap()
        .map(_mapIndexValueToIndexRouletteItemList)
        .values
        .toList()
        .reduce(
          (value, element) => value..addAll(element),
        );
  }

  MapEntry<int, List<RouletteItem>> _mapIndexValueToIndexRouletteItemList(
    index,
    value,
  ) {
    final newValue = _generateList(length: value, type: _getTypeByIndex(index));
    return MapEntry(index, newValue);
  }

  List<RouletteItem> _generateList({
    required int length,
    required RouletteType type,
  }) {
    return List.generate(
      length,
      (index) => RouletteItem(type: type),
      growable: true,
    );
  }

  RouletteType _getTypeByIndex(int index) =>
      _isFailedIndex(index) ? RouletteType.failed : RouletteType.success;

  bool _isFailedIndex(int index) => index % 2 == 0;

  SpinConfiguration getSpinConfiguration(bool specialMode) {
    return specialMode ? specialSpinConfiguration : spinConfiguration;
  }
}
