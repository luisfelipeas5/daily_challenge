import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/domain/entities/spin_configuration/spin_configuration.dart';

class GenerateRandomSpinOffset {
  int call({
    required int roulleteItemsCount,
    required SpinConfiguration spinConfiguration,
  }) {
    final realCenterItemIndex = Random().nextInt(roulleteItemsCount);
    final indexInitialOffset = spinConfiguration.indexInitialOffset;
    return indexInitialOffset + realCenterItemIndex;
  }
}
