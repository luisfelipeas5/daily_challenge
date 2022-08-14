import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

const _relativeAudioPercent = 0.1;

class RouletteSoundPlayer extends StatefulWidget {
  final Widget child;

  const RouletteSoundPlayer({
    super.key,
    required this.child,
  });

  @override
  State<RouletteSoundPlayer> createState() => _RouletteSoundPlayerState();
}

class _RouletteSoundPlayerState extends State<RouletteSoundPlayer>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _player.setAsset("resources/sounds/spin.mp3");
  }

  @override
  void dispose() {
    _player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _stopIfPlaying();
        break;
      case AppLifecycleState.resumed:
        _onAppResumed();
        break;
      default:
    }
  }

  void _onAppResumed() {
    final state = BlocProvider.of<RouletteBloc>(context).state;
    _playIfSpinning(state);
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
    _stopIfPlaying();
    _playIfSpinning(state);
  }

  void _playIfSpinning(RouletteState state) {
    if (state.pageStatus.isSpinning() && state.specialMode) {
      _seekToStartIfAlmostEnd();
      _player.play();
    }
  }

  void _stopIfPlaying() {
    if (_player.playing) {
      _player.stop();
    }
  }

  void _seekToStartIfAlmostEnd() {
    var totalDuration = (_player.duration?.inMilliseconds ?? 0);
    final percent = _player.position.inMilliseconds / totalDuration;
    if (percent > _relativeAudioPercent) {
      _player.seek(Duration.zero);
    }
  }
}
