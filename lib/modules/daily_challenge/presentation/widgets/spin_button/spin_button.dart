import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/text_card_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpinButton extends StatelessWidget {
  const SpinButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouletteBloc, RouletteState>(
      buildWhen: (previous, current) =>
          previous.specialMode != current.specialMode,
      builder: (context, state) {
        return TextCardButton(
          text: state.specialMode ? "Rodar? 👀" : "Rodar",
          minWidth: 213,
          onTap: () => _onTap(context),
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    final bloc = BlocProvider.of<RouletteBloc>(context);
    if (bloc.state.pageStatus.isIdle()) {
      bloc.add(RouletteSpinEvent());
    }
  }
}
