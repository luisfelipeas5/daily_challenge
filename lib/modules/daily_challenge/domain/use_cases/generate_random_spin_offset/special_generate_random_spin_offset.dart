import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';

class SpecialGenerateRandomSpinOffset {
  int call({
    required RouletteConfiguration configuration,
  }) {
    return configuration.specialPattern.reduce(
          (value, element) => value + element,
        ) -
        1;
  }
}
