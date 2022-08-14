import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/shared/widgets/coin/animated_translation_sensor_coin.dart';
import 'package:daily_challenge/shared/widgets/coin/coin.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraggableCoin extends StatefulWidget {
  final double size;

  const DraggableCoin({
    super.key,
    required this.size,
  });

  @override
  State<DraggableCoin> createState() => _DraggableCoinState();
}

class _DraggableCoinState extends State<DraggableCoin> {
  RouletteBloc get _bloc => BlocProvider.of(context);
  var dragged = false;

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
      child: dragged
          ? Container()
          : AnimatedTranslationSensorCoin(
              size: widget.size,
            ),
    );
  }

  void _onDragCompleted() {
    setState(() {
      dragged = true;
    });
  }

  void _onDraggin(bool dragging) {
    _bloc.add(
      RouletteDraggingCoinEvent(dragging: dragging),
    );
  }
}
