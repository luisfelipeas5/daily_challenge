import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_background/draggable_coin.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/coins_drag_target/limit_indicator.dart';
import 'package:daily_challenge/shared/widgets/coin/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialCoinsDragTarget extends StatefulWidget {
  const SpecialCoinsDragTarget({
    super.key,
  });

  @override
  State<SpecialCoinsDragTarget> createState() => _SpecialCoinsDragTargetState();
}

class _SpecialCoinsDragTargetState extends State<SpecialCoinsDragTarget> {
  final _offsetMap = <DraggableCoin, Offset>{};

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 3,
          child: _buildLimitIndicator(),
        ),
        SizedBox(
          height: 100,
          child: _buildDragTarget(),
        ),
      ],
    );
  }

  void _onAcceptWithDetails(DragTargetDetails<DraggableCoin> details) {
    _offsetMap[details.data] = details.offset;

    final bloc = BlocProvider.of<RouletteBloc>(context);
    bloc.add(RouletteCoinDraggedEvent());
  }

  Widget _builder(
    BuildContext context,
    List<DraggableCoin?> candidateData,
    List rejectedData,
  ) {
    return Stack(
      children: _offsetMap.map(_widgetMapper).values.toList(),
    );
  }

  MapEntry<DraggableCoin, Widget> _widgetMapper(
    DraggableCoin draggableCoin,
    Offset globalOffset,
  ) =>
      MapEntry(
        draggableCoin,
        _getPositioned(draggableCoin, globalOffset),
      );

  Widget _getPositioned(
    DraggableCoin key,
    Offset globalOffset,
  ) {
    final offsetNormalized = _getOffsetNormalized(globalOffset);
    return Positioned(
      top: offsetNormalized.dy,
      left: offsetNormalized.dx,
      child: Coin(
        size: key.size,
      ),
    );
  }

  Offset _getOffsetNormalized(Offset globalOffset) {
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      final localOffset = renderObject.globalToLocal(globalOffset);
      return localOffset;
    }
    return const Offset(
      0,
      0,
    );
  }

  Widget _buildLimitIndicator() {
    return BlocBuilder<RouletteBloc, RouletteState>(
      buildWhen: (previous, current) =>
          previous.draggingCoin != current.draggingCoin,
      builder: (context, state) {
        if (state.draggingCoin) {
          return const LimitIndicator();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<DraggableCoin>(
      onAcceptWithDetails: _onAcceptWithDetails,
      builder: _builder,
    );
  }
}
