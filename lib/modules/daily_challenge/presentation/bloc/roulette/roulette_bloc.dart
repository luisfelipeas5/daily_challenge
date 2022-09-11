import 'dart:async';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/generate_random_spin_offset/generate_random_spin_offset.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/generate_random_spin_offset/special_generate_random_spin_offset.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/use_cases/roulette_configuration_stream/roulette_configuration_stream.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  final GenerateRandomSpinOffset _generateRandomOffset;
  final SpecialGenerateRandomSpinOffset _specialGenerateRandomOffset;
  final RouletteConfigurationStream _rouletteConfigurationStream;

  int _coinsAdded = 0;
  int _coinsDragged = 0;
  double _logoScale = 1;

  RouletteBloc(
    this._generateRandomOffset,
    this._specialGenerateRandomOffset,
    this._rouletteConfigurationStream,
  ) : super(
          RouletteState(
            configuration: RouletteConfiguration.empty(),
            pageStatus: RoulettePageStatus.idle,
            specialMode: false,
            draggingCoin: false,
            logoBlinking: false,
          ),
        ) {
    on<RouletteLoadEvent>(_onLoad);
    on<RouletteSpinEvent>(_onSpin);
    on<RouletteSpinStoppedEvent>(_spinStopped);
    on<RouletteAddCoinEvent>(_onAddCoin);
    on<RouletteCoinDraggedEvent>(_onCoinDragged);
    on<RouletteDraggingCoinEvent>(_onDraggingCoin);
    on<RouletteLogoScaleUpdatedEvent>(_onLogoScaleUpdateCoin);
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
    final randomOffset = _getRandomOffset();

    emit(state.copyWith(
      pageStatus: RoulettePageStatus.spinning,
      centerItemIndex: randomOffset,
    ));
  }

  int _getRandomOffset() {
    final generateRandomOffset = state.specialMode
        ? _specialGenerateRandomOffset.call
        : _generateRandomOffset.call;
    return generateRandomOffset(
      configuration: state.configuration,
    );
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
      final rouletteItems = state.configuration.getRouletteItems(_specialMode);
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
    _coinsAdded++;
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
    _coinsDragged++;
    emit(state.copyWith(
      specialMode: _specialMode,
      logoBlinking: _logoBlinking,
    ));
  }

  FutureOr<void> _onLogoScaleUpdateCoin(
    RouletteLogoScaleUpdatedEvent event,
    Emitter<RouletteState> emit,
  ) {
    _logoScale = event.scale;
    emit(state.copyWith(
      specialMode: _specialMode,
      logoBlinking: _logoBlinking,
    ));
  }

  bool get _specialMode => _coinsAdded == _coinsDragged && _logoScale == 1;

  bool get _logoBlinking {
    final missingCoinsToDrag = _coinsAdded - _coinsDragged;
    return missingCoinsToDrag == 1 || _logoScale != 1;
  }
}
