import 'package:daily_challenge/firebase_options.dart';
import 'package:daily_challenge/modules/app/app.dart';
import 'package:daily_challenge/modules/daily_challenge/data/data_sources/remote_data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool remoteDataSourceWebConfigInit = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final unleash = RemoteDataSource.newUnleashInstance();
  final remoteDataSource = RemoteDataSource(unleash);
  await remoteDataSource.init();
  remoteDataSource.setUpInitialParameters();

  runApp(App(
    remoteDataSource: remoteDataSource,
  ));
}
