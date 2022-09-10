import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';

class GenerateRandomSpinOffset {
  int call({
    required RouletteConfiguration configuration,
  }) {
    final rouletteItems = configuration.getRouletteItems(false);
    final roulleteItemsCount = rouletteItems.length;
    final realCenterItemIndex = Random().nextInt(roulleteItemsCount);

    final spinConfiguration = configuration.getSpinConfiguration(false);
    final indexInitialOffset = spinConfiguration.indexInitialOffset;

    return indexInitialOffset + realCenterItemIndex;
  }
}
