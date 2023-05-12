import 'package:daily_challenge/firebase_options.dart';
import 'package:daily_challenge/modules/app/app.dart';
import 'package:daily_challenge/modules/daily_challenge/data/data_sources/remote_data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';

bool remoteDataSourceWebConfigInit = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const apiKey = String.fromEnvironment("growth_book_api_key");
  final growthBookSdkInstance = await GBSDKBuilderApp(
    apiKey: apiKey,
    hostURL: 'https://cdn.growthbook.io/',
    growthBookTrackingCallBack: (gbExperiment, gbExperimentResult) {},
  ).initialize();
  final remoteDataSource = RemoteDataSource(growthBookSdkInstance);
  remoteDataSource.setUpInitialParameters();

  runApp(App(
    remoteDataSource: remoteDataSource,
  ));
}
