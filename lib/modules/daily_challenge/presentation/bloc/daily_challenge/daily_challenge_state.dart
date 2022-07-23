import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/daily_challenge/daily_challenge_page_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class DailyChallengeState extends Equatable {
  final List<RouletteItem> rouletteItems;
  final DailyChallengePageStatus pageStatus;
  final int? centerItemIndex;

  const DailyChallengeState({
    required this.rouletteItems,
    required this.pageStatus,
    this.centerItemIndex,
  });

  @override
  List<Object?> get props => [
        pageStatus,
        rouletteItems,
        centerItemIndex,
      ];

  DailyChallengeState copyWith({
    List<RouletteItem>? rouletteItems,
    DailyChallengePageStatus? pageStatus,
    int? centerItemIndex,
  }) {
    return DailyChallengeState(
      rouletteItems: rouletteItems ?? this.rouletteItems,
      pageStatus: pageStatus ?? this.pageStatus,
      centerItemIndex: centerItemIndex ?? this.centerItemIndex,
    );
  }
}
