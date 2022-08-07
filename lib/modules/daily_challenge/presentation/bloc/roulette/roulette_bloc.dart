import 'dart:async';
import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int _centerItemIndexMultiplier = 10;
const int _centerItemIndexInitialOffset = 20;

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  RouletteBloc()
      : super(
          const RouletteState(
            rouletteItems: [],
            pageStatus: RoulettePageStatus.idle,
          ),
        ) {
    on<RouletteLoadEvent>(_onLoad);
    on<RouletteSpinEvent>(_onSpin);
    on<RouletteSpinStoppedEvent>(_spinStopped);
    on<RouletteSuccessDialogCloseEvent>(_onSuccessDialogClose);
    on<RouletteFailedDialogCloseEvent>(_onFailedDialogClose);
  }

  FutureOr<void> _onLoad(
    RouletteLoadEvent event,
    Emitter<RouletteState> emit,
  ) {
    const rouletteItems = [
      RouletteItem(type: RouletteType.failed),
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
    final realCenterItemIndex = Random().nextInt(state.rouletteItems.length);
    final actualItemIndex = state.centerItemIndex ?? 0;
    final centerItemIndex = actualItemIndex +
        _centerItemIndexInitialOffset +
        (realCenterItemIndex * _centerItemIndexMultiplier);

    emit(state.copyWith(
      pageStatus: RoulettePageStatus.spinning,
      centerItemIndex: centerItemIndex,
    ));
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
}
