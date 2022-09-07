import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/spin_configuration/spin_configuration.dart';

class LocalDataSource {
  RouletteConfiguration getRouletteConfiguration() {
    return RouletteConfiguration(
      pattern: _defaultRoulettePattern,
      spinConfiguration: SpinConfiguration(
        durationInMilliseconds: 3000,
        indexMultiplier: 10,
        indexInitialOffset: 20,
      ),
      specialSpinConfiguration: SpinConfiguration(
        durationInMilliseconds: 15000,
        indexMultiplier: 50,
        indexInitialOffset: 1000,
      ),
    );
  }

  List<int> get _defaultRoulettePattern => [10, 1];
}
