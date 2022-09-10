import 'package:daily_challenge/modules/app/text_theme.dart';
import 'package:daily_challenge/modules/daily_challenge/data/data_sources/remote_data_source.dart';
import 'package:daily_challenge/modules/daily_challenge/data/di/data_dependency_injector.dart';
import 'package:daily_challenge/modules/daily_challenge/dependencies/roulette_page_dependencies.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/di/use_cases/use_cases_dependency_injector.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/roulette_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/redirector/roulette_page_redirector/roulette_page_redirector.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final RemoteDataSource remoteDataSource;

  const App({
    super.key,
    required this.remoteDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const AppTextTheme(),
      ),
      home: DataDependencyInjector(
        remoteDataSource: remoteDataSource,
        child: UseCasesDependencyInjector(
          child: RoulettePageDependencyInjector(
            child: const RoulettePageRedirector(
              child: RoulettePage(),
            ),
          ),
        ),
      ),
    );
  }
}
