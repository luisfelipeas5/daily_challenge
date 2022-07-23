import 'dart:async';
import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const int _centerItemIndexMultiplier = 10;
const int _centerItemIndexInitialOffset = 20;

class DailyChallengeBloc
    extends Bloc<DailyChallengeEvent, DailyChallengeState> {
  DailyChallengeBloc()
      : super(
          const DailyChallengeState(
            rouletteItems: [],
            pageStatus: DailyChallengePageStatus.idle,
          ),
        ) {
    on<DailyChallengeLoadEvent>(_onLoad);
    on<DailyChallengeSpinEvent>(_onSpin);
    on<DailyChallengeSpinStoppedEvent>(_spinStopped);
  }

  FutureOr<void> _onLoad(
    DailyChallengeLoadEvent event,
    Emitter<DailyChallengeState> emit,
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
    DailyChallengeSpinEvent event,
    Emitter<DailyChallengeState> emit,
  ) {
    final realCenterItemIndex = Random().nextInt(state.rouletteItems.length);
    final centerItemIndex = _centerItemIndexInitialOffset +
        (realCenterItemIndex * _centerItemIndexMultiplier);

    emit(state.copyWith(
      pageStatus: DailyChallengePageStatus.spinning,
      centerItemIndex: centerItemIndex,
    ));
  }

  FutureOr<void> _spinStopped(
    DailyChallengeSpinStoppedEvent event,
    Emitter<DailyChallengeState> emit,
  ) {
    final newPageStatus = _getPageStatusAfterSpinningStopped();
    emit(state.copyWith(
      pageStatus: newPageStatus,
    ));
  }

  DailyChallengePageStatus _getPageStatusAfterSpinningStopped() {
    if (_isRouletteItemSuccessType()) {
      return DailyChallengePageStatus.success;
    }
    return DailyChallengePageStatus.failed;
  }

  bool _isRouletteItemSuccessType() {
    final rouletteItems = state.rouletteItems;
    final length = rouletteItems.length;
    final centerItemIndex = state.centerItemIndex;
    if (centerItemIndex != null) {
      final rouletteItem = rouletteItems[centerItemIndex % length];
      return rouletteItem.type == RouletteType.success;
    }
    return false;
  }
}
