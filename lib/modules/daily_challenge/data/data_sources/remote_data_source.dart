import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_configuration/roulette_configuration_model.dart';
import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';

const _platformKey = "platform";

class RemoteDataSource {
  final UnleashClient _unleash;

  RemoteDataSource(
    this._unleash,
  );

  static UnleashClient newUnleashInstance() {
    const apiKey = String.fromEnvironment("unleash_api_key");
    return UnleashClient(
      url: Uri.parse('https://unleash.soudaki/api/frontend'),
      clientKey: apiKey,
      appName: 'daily_challenge',
      
    );
  }

  Future<void> init() {
    final completer = Completer();
    _unleash.on('ready', (_) {
      completer.complete();
    });
    _unleash.start();
    return completer.future;
  }

  void setUpInitialParameters() {
    _unleash.setContextField(_platformKey, Platform.operatingSystem);
  }

  RouletteConfigurationModel? getRouletteConfiguration() {
    final isEnabled = _unleash.isEnabled("roulette_configuration");
    final variant = _unleash.getVariant("roulette_configuration");
    final featureResult = variant.payload?.value;
    if (featureResult == null) return null;

    return RouletteConfigurationModel.fromJson(
      jsonDecode(featureResult),
    );
  }
}
