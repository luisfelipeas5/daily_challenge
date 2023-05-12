import 'dart:io';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_configuration/roulette_configuration_model.dart';
import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';

const _platformKey = "platform";

class RemoteDataSource {
  final GrowthBookSDK _growthBookSdkInstance;

  RemoteDataSource(
    this._growthBookSdkInstance,
  );

  void setUpInitialParameters() {
    _growthBookSdkInstance.setAttributes({
      _platformKey: Platform.operatingSystem,
    });
  }

  RouletteConfigurationModel? getRouletteConfiguration() {
    final featureResult =
        _growthBookSdkInstance.feature("roulette_configuration").value;
    if (featureResult == null) return null;

    return RouletteConfigurationModel.fromJson(
      featureResult,
    );
  }
}
