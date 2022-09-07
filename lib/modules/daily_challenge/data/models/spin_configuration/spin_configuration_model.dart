import 'package:daily_challenge/modules/daily_challenge/domain/entities/spin_configuration/spin_configuration.dart';

class SpinConfigurationModel extends SpinConfiguration {
  SpinConfigurationModel._({
    required super.durationInMilliseconds,
    required super.indexMultiplier,
    required super.indexInitialOffset,
  });

  factory SpinConfigurationModel.fromJson(Map<String, dynamic> data) {
    return SpinConfigurationModel._(
      durationInMilliseconds: data['duration_in_milliseconds'] as int,
      indexMultiplier: data['index_multiplier'] as int,
      indexInitialOffset: data['index_initial_offset'] as int,
    );
  }
}
