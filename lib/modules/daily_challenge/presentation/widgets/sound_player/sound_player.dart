import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class RouletteSoundPlayer extends StatefulWidget {
  final Widget child;

  const RouletteSoundPlayer({
    super.key,
    required this.child,
  });

  @override
  State<RouletteSoundPlayer> createState() => _RouletteSoundPlayerState();
}

class _RouletteSoundPlayerState extends State<RouletteSoundPlayer> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _player.setAsset("resources/sounds/spin.mp3");
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RouletteBloc, RouletteState>(
      listener: _listener,
      child: widget.child,
    );
  }

  void _listener(
    BuildContext context,
    RouletteState state,
  ) {
    if (state.pageStatus.isSpinning()) {
      _player.play();
    } else if (_player.playing) {
      _player.stop();
    }
  }
}
