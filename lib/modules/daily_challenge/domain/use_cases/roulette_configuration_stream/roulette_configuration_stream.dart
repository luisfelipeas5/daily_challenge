import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/repository/repository.dart';

class RouletteConfigurationStream {
  final Repository _repository;

  RouletteConfigurationStream(
    this._repository,
  );

  Stream<RouletteConfiguration> call() {
    return _repository.getRouletteConfigurationStream();
  }
}
