import 'package:daily_challenge/modules/app/text_theme.dart';
import 'package:daily_challenge/modules/daily_challenge/dependencies/daily_challenge_page_dependencies.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/redirector/app_page_redirector/app_page_redirector.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const AppTextTheme(),
      ),
      home: DailyChallengePageDependencies(
        child: const AppPageRedirector(),
      ),
    );
  }
}
