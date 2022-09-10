import 'package:daily_challenge/modules/daily_challenge/data/models/spin_configuration/spin_configuration_model.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/spin_configuration/spin_configuration.dart';

class RouletteConfigurationModel extends RouletteConfiguration {
  RouletteConfigurationModel._({
    required super.pattern,
    required super.specialPattern,
    required super.spinConfiguration,
    required super.specialSpinConfiguration,
  });

  factory RouletteConfigurationModel.fromJson(Map<String, dynamic> data) {
    return RouletteConfigurationModel._(
      pattern: _getRoulettePatternFromData(data['pattern']),
      specialPattern: _getRoulettePatternFromData(data['special_pattern']),
      spinConfiguration:
          _getSpinConfigurationFromData(data['spin_configuration']),
      specialSpinConfiguration:
          _getSpinConfigurationFromData(data['special_spin_configuration']),
    );
  }

  static RoulettePattern _getRoulettePatternFromData(dynamic data) {
    return (data as List).map((e) => e as int).toList();
  }

  static SpinConfiguration _getSpinConfigurationFromData(
    Map<String, dynamic>? data,
  ) {
    return data == null
        ? SpinConfiguration.empty()
        : SpinConfigurationModel.fromJson(data);
  }
}
