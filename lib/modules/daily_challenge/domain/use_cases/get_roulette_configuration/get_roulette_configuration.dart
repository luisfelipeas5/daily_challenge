import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/repository/repository.dart';

class GetRouletteConfiguration {
  final Repository _repository;

  GetRouletteConfiguration(
    this._repository,
  );

  RouletteConfiguration call() {
    return _repository.getRouletteConfigurationStream();
  }
}
