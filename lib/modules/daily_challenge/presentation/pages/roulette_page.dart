import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/instructions/roulette_instructions.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/logo/logo_space.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/page_roulette.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/sound_player/sound_player.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/spin_button/spin_button.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_background/page_coins_background.dart';
import 'package:daily_challenge/shared/widgets/page_background/page_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoulettePage extends StatefulWidget {
  const RoulettePage({
    super.key,
  });

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> {
  RouletteBloc get _bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    _bloc.add(RouletteLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
        child: PageCoinsBackground(
          child: SafeArea(
            child: RouletteSoundPlayer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: LogoSpace(),
                  ),
                  Expanded(
                    child: _buildRoulette(),
                  ),
                  Expanded(
                    child: _builtBottom(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoulette() {
    return const PageRoulette();
  }

  Widget _builtBottom() {
    return Column(
      children: const [
        RouletteInstructions(),
        SizedBox(height: 43),
        SpinButton(),
      ],
    );
  }
}
