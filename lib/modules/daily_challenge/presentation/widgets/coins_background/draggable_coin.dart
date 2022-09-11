import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/shared/widgets/coin/animated_translation_sensor_coin.dart';
import 'package:daily_challenge/shared/widgets/coin/coin.dart';
import 'package:daily_challenge/shared/widgets/shake/shake.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraggableCoin extends StatefulWidget {
  final double size;
  final bool shaking;

  const DraggableCoin({
    super.key,
    required this.size,
    required this.shaking,
  });

  @override
  State<DraggableCoin> createState() => _DraggableCoinState();
}

class _DraggableCoinState extends State<DraggableCoin> {
  RouletteBloc get _bloc => BlocProvider.of(context);
  bool draggedOnce = false;
  bool dragged = false;

  @override
  void initState() {
    super.initState();
    _bloc.add(RouletteAddCoinEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<DraggableCoin>(
      data: widget,
      feedback: Coin(
        size: widget.size,
      ),
      childWhenDragging: Container(),
      onDragCompleted: _onDragCompleted,
      onDragStarted: () => _onDraggin(true),
      onDragEnd: (_) => _onDraggin(false),
      child: dragged ? Container() : _buildDraggableChildWhenNotDragged(),
    );
  }

  Widget _buildDraggableChildWhenNotDragged() {
    return Shake(
      shakeCount: 6,
      shakeOffset: 3,
      animationDelay: _randomShakingDelay,
      animationDuration: const Duration(milliseconds: 600),
      shaking: widget.shaking,
      child: AnimatedTranslationSensorCoin(
        size: widget.size,
        delayAnimation: !draggedOnce,
      ),
    );
  }

  Duration get _randomShakingDelay {
    final randomSeconds = Random().nextInt(10);
    return Duration(seconds: 10 + randomSeconds);
  }

  void _onDragCompleted() {
    setState(() {
      dragged = true;
    });
  }

  void _onDraggin(bool dragging) {
    if (!draggedOnce) {
      setState(() {
        draggedOnce = true;
      });
    }

    _bloc.add(
      RouletteDraggingCoinEvent(dragging: dragging),
    );
  }
}
