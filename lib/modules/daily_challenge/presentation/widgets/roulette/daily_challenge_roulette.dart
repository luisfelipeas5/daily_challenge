import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyChallengeRoulette extends StatelessWidget {
  const DailyChallengeRoulette({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChallengeBloc, DailyChallengeState>(
      builder: (context, state) {
        return Roulette(
          rouletteItems: state.rouletteItems,
          status: _getRouletteStatus(state),
          centerItemIndex: state.centerItemIndex,
          onSpinningStopped: () => _onSpinningStopped(context),
        );
      },
    );
  }

  RouletteStatus _getRouletteStatus(DailyChallengeState state) {
    if (state.pageStatus.isSpinning()) {
      return RouletteStatus.spinning;
    }
    return RouletteStatus.idle;
  }

  void _onSpinningStopped(BuildContext context) {
    final bloc = BlocProvider.of<DailyChallengeBloc>(context);
    bloc.add(DailyChallengeSpinStoppedEvent());
  }
}
