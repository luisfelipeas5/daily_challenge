import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DailyChallengePageDependencies extends MultiProvider {
  DailyChallengePageDependencies({
    super.key,
    required Widget child,
  }) : super(
          providers: [
            const BlocProvider(
              create: _newDailyChallengeBlocInstance,
            ),
          ],
          child: child,
        );

  static DailyChallengeBloc _newDailyChallengeBlocInstance(
    BuildContext context,
  ) {
    return DailyChallengeBloc();
  }
}
