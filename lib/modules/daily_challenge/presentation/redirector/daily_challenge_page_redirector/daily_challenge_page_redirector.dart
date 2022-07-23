import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/daily_challenge_failed_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/daily_challenge_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/daily_challenge_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyChallengePageRedirector extends StatelessWidget {
  const DailyChallengePageRedirector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChallengeBloc, DailyChallengeState>(
      builder: (context, state) {
        return Stack(
          children: [
            const DailyChallengePage(),
            if (state.pageStatus.isSuccess()) const DailyChallengeSuccessPage(),
            if (state.pageStatus.isFailed()) const DailyChallengeFailedPage(),
          ],
        );
      },
    );
  }
}
