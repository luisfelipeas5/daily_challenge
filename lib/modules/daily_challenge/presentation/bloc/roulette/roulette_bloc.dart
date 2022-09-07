import 'dart:async';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/generate_random_spin_offset/generate_random_spin_offset.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/roulette_configuration_stream/roulette_configuration_stream.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  final GenerateRandomSpinOffset _generateRandomOffset;
  final RouletteConfigurationStream _rouletteConfigurationStream;

  int coinsAdded = 0;
  int coinsDragged = 0;

  RouletteBloc(
    this._generateRandomOffset,
    this._rouletteConfigurationStream,
  ) : super(
          RouletteState(
            configuration: RouletteConfiguration.empty(),
            pageStatus: RoulettePageStatus.idle,
            specialMode: false,
            draggingCoin: false,
          ),
        ) {
    on<RouletteLoadEvent>(_onLoad);
    on<RouletteSpinEvent>(_onSpin);
    on<RouletteSpinStoppedEvent>(_spinStopped);
    on<RouletteAddCoinEvent>(_onAddCoin);
    on<RouletteCoinDraggedEvent>(_onCoinDragged);
    on<RouletteDraggingCoinEvent>(_onDraggingCoin);
  }

  FutureOr<void> _onLoad(
    RouletteLoadEvent event,
    Emitter<RouletteState> emit,
  ) async {
    await emit.forEach<RouletteConfiguration>(
      _rouletteConfigurationStream(),
      onData: (data) {
        return state.copyWith(
          configuration: data,
        );
      },
    );
  }

  FutureOr<void> _onSpin(
    RouletteSpinEvent event,
    Emitter<RouletteState> emit,
  ) {
    final randomOffset = _generateRandomOffset(
      roulleteItemsCount: state.configuration.rouletteItems.length,
      spinConfiguration:
          state.configuration.getSpinConfiguration(state.specialMode),
    );
    final actualItemIndex = state.centerItemIndex ?? 0;

    emit(state.copyWith(
      pageStatus: RoulettePageStatus.spinning,
      centerItemIndex: actualItemIndex + randomOffset,
    ));
  }

  FutureOr<void> _spinStopped(
    RouletteSpinStoppedEvent event,
    Emitter<RouletteState> emit,
  ) async {
    final newPageStatus = _getPageStatusAfterSpinningStopped();
    emit(state.copyWith(
      pageStatus: newPageStatus,
    ));

    await Future.delayed(const Duration(milliseconds: 700));
    emit(state.copyWith(
      pageStatus: RoulettePageStatus.idle,
    ));
  }

  RoulettePageStatus _getPageStatusAfterSpinningStopped() {
    if (_isRouletteItemSuccessType()) {
      return RoulettePageStatus.success;
    }
    return RoulettePageStatus.failed;
  }

  bool _isRouletteItemSuccessType() {
    final centerItemIndex = state.centerItemIndex;
    if (centerItemIndex != null) {
      final rouletteItems = state.configuration.rouletteItems;
      final length = rouletteItems.length;
      final rouletteItem = rouletteItems[centerItemIndex % length];
      return rouletteItem.type.isSuccess;
    }
    return false;
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
