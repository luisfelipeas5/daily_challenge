import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';

class RouletteConfigurationModel extends RouletteConfiguration {
  RouletteConfigurationModel._({
    required super.pattern,
  });

  factory RouletteConfigurationModel.fromJson(Map<String, dynamic> data) {
    return RouletteConfigurationModel._(
      pattern: (data['pattern'] as List).map((e) => e as int).toList(),
    );
  }
}
