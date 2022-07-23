import 'package:daily_challenge/features/app/text_theme.dart';
import 'package:daily_challenge/features/daily_challenge/page/daily_challenge_page.dart';
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
      home: const DailyChallengePage(),
    );
  }
}
