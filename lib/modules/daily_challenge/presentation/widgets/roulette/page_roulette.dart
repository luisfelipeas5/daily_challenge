import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _spinDuration = Duration(milliseconds: 3000);
const _specialSpinDuration = Duration(milliseconds: 15000);

class PageRoulette extends StatelessWidget {
  const PageRoulette({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouletteBloc, RouletteState>(
      builder: (context, state) {
        return Roulette.byContext(
          context,
          rouletteItems: state.rouletteItems,
          status: _getRouletteStatus(state),
          centerItemIndex: state.centerItemIndex,
          spinDuration: _getSpinDuration(state),
          onSpinningStopped: () => _onSpinningStopped(context),
        );
      },
    );
  }

  Duration _getSpinDuration(RouletteState state) =>
      state.specialMode ? _specialSpinDuration : _spinDuration;

  RouletteStatus _getRouletteStatus(RouletteState state) {
    if (state.pageStatus.isSpinning()) {
      return RouletteStatus.spinning;
    }
    return RouletteStatus.idle;
  }

  void _onSpinningStopped(BuildContext context) {
    final bloc = BlocProvider.of<RouletteBloc>(context);
    bloc.add(RouletteSpinStoppedEvent());
  }
}
