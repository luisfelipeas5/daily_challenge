import 'dart:async';
import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int _centerItemIndexMultiplier = 10;
const int _centerItemIndexInitialOffset = 20;

const int _specialCenterItemIndexMultiplier = 50;
const int _specialCenterItemIndexInitialOffset = 100;

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  var coinsAdded = 0;
  var coinsDragged = 0;

  RouletteBloc()
      : super(
          const RouletteState(
            rouletteItems: [],
            pageStatus: RoulettePageStatus.idle,
            specialMode: false,
            draggingCoin: false,
          ),
        ) {
    on<RouletteLoadEvent>(_onLoad);
    on<RouletteSpinEvent>(_onSpin);
    on<RouletteSpinStoppedEvent>(_spinStopped);
    on<RouletteSuccessDialogCloseEvent>(_onSuccessDialogClose);
    on<RouletteFailedDialogCloseEvent>(_onFailedDialogClose);
    on<RouletteAddCoinEvent>(_onAddCoin);
    on<RouletteCoinDraggedEvent>(_onCoinDragged);
    on<RouletteDraggingCoinEvent>(_onDraggingCoin);
  }

  FutureOr<void> _onLoad(
    RouletteLoadEvent event,
    Emitter<RouletteState> emit,
  ) {
    const rouletteItems = [
      RouletteItem(type: RouletteType.failed),
      RouletteItem(type: RouletteType.success),
    ];
    emit(state.copyWith(
      rouletteItems: rouletteItems,
    ));
  }

  FutureOr<void> _onSpin(
    RouletteSpinEvent event,
    Emitter<RouletteState> emit,
  ) {
    final centerItemIndex = _generateRandomCenterItemIndex();

    emit(state.copyWith(
      pageStatus: RoulettePageStatus.spinning,
      centerItemIndex: centerItemIndex,
    ));
  }

  int _generateRandomCenterItemIndex() {
    final realCenterItemIndex = Random().nextInt(state.rouletteItems.length);
    final actualItemIndex = state.centerItemIndex ?? 0;
    return actualItemIndex +
        _getCenterItemIndexInitialOffset() +
        (realCenterItemIndex * _getCenterItemIndexMultiplier()) +
        realCenterItemIndex;
  }

  int _getCenterItemIndexMultiplier() {
    return state.specialMode
        ? _specialCenterItemIndexMultiplier
        : _centerItemIndexMultiplier;
  }

  int _getCenterItemIndexInitialOffset() {
    return state.specialMode
        ? _specialCenterItemIndexInitialOffset
        : _centerItemIndexInitialOffset;
  }

  FutureOr<void> _spinStopped(
    RouletteSpinStoppedEvent event,
    Emitter<RouletteState> emit,
  ) {
    final newPageStatus = _getPageStatusAfterSpinningStopped();
    emit(state.copyWith(
      pageStatus: newPageStatus,
    ));
  }

  RoulettePageStatus _getPageStatusAfterSpinningStopped() {
    if (_isRouletteItemSuccessType()) {
      return RoulettePageStatus.success;
    }
    return RoulettePageStatus.failed;
  }

  bool _isRouletteItemSuccessType() {
    final rouletteItems = state.rouletteItems;
    final length = rouletteItems.length;
    final centerItemIndex = state.centerItemIndex;
    if (centerItemIndex != null) {
      final rouletteItem = rouletteItems[centerItemIndex % length];
      return rouletteItem.type.success;
    }
    return false;
  }

  FutureOr<void> _onSuccessDialogClose(
    RouletteSuccessDialogCloseEvent event,
    Emitter<RouletteState> emit,
  ) {
    emit(state.copyWith(
      pageStatus: RoulettePageStatus.idle,
    ));
  }

  FutureOr<void> _onFailedDialogClose(
    RouletteFailedDialogCloseEvent event,
    Emitter<RouletteState> emit,
  ) {
    emit(state.copyWith(
      pageStatus: RoulettePageStatus.idle,
    ));
  }

  FutureOr<void> _onAddCoin(
    RouletteAddCoinEvent event,
    Emitter<RouletteState> emit,
  ) {
    coinsAdded++;
  }

  FutureOr<void> _onDraggingCoin(
    RouletteDraggingCoinEvent event,
    Emitter<RouletteState> emit,
  ) {
    emit(state.copyWith(
      draggingCoin: event.dragging,
    ));
  }

  FutureOr<void> _onCoinDragged(
    RouletteCoinDraggedEvent event,
    Emitter<RouletteState> emit,
  ) {
    coinsDragged++;
    if (coinsAdded == coinsDragged) {
      emit(state.copyWith(
        specialMode: true,
      ));
    }
  }
}
