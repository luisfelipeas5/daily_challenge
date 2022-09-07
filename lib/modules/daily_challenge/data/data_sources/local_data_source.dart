import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';

class LocalDataSource {
  RouletteConfiguration getRouletteConfiguration() {
    return RouletteConfiguration(
      pattern: _defaultRoulettePattern,
    );
  }

  List<int> get _defaultRoulettePattern => [10, 1];
}
