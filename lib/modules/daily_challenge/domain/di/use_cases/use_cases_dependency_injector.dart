import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/generate_random_spin_offset/generate_random_spin_offset.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/generate_random_spin_offset/special_generate_random_spin_offset.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/get_roulette_configuration/get_roulette_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UseCasesDependencyInjector extends MultiProvider {
  UseCasesDependencyInjector({
    super.key,
    super.child,
  }) : super(
          providers: [
            Provider(create: _generateRandomOffsetCreator),
            Provider(create: _specialGenerateRandomOffsetCreator),
            Provider(create: _rouletteConfigurationStreamCreator),
          ],
        );

  static GenerateRandomSpinOffset _generateRandomOffsetCreator(
      BuildContext context) {
    return GenerateRandomSpinOffset();
  }

  static SpecialGenerateRandomSpinOffset _specialGenerateRandomOffsetCreator(
      BuildContext context) {
    return SpecialGenerateRandomSpinOffset();
  }

  static GetRouletteConfiguration _rouletteConfigurationStreamCreator(
      BuildContext context) {
    return GetRouletteConfiguration(
      context.read(),
    );
  }
}
