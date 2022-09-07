import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';

abstract class Repository {
  Stream<RouletteConfiguration> getRouletteConfigurationStream();
}
