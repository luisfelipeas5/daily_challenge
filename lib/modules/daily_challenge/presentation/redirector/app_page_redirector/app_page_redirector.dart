import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/failed_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/roulette_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPageRedirector extends StatelessWidget {
  const AppPageRedirector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouletteBloc, RouletteState>(
      builder: (context, state) {
        return Stack(
          children: [
            const RoulettePage(),
            if (state.pageStatus.isSuccess()) const SuccessPage(),
            if (state.pageStatus.isFailed()) const FailedPage(),
          ],
        );
      },
    );
  }
}
