import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class RouletteState extends Equatable {
  final RouletteConfiguration configuration;
  final RoulettePageStatus pageStatus;
  final int? centerItemIndex;
  final bool specialMode;
  final bool draggingCoin;

  const RouletteState({
    required this.configuration,
    required this.pageStatus,
    required this.specialMode,
    required this.draggingCoin,
    this.centerItemIndex,
  });

  @override
  List<Object?> get props => [
        pageStatus,
        configuration,
        centerItemIndex,
        specialMode,
        draggingCoin,
      ];

  RouletteState copyWith({
    List<RouletteItem>? rouletteItems,
    RoulettePageStatus? pageStatus,
    int? centerItemIndex,
    bool? specialMode,
    bool? draggingCoin,
    RouletteConfiguration? configuration,
  }) {
    return RouletteState(
      configuration: configuration ?? this.configuration,
      pageStatus: pageStatus ?? this.pageStatus,
      centerItemIndex: centerItemIndex ?? this.centerItemIndex,
      specialMode: specialMode ?? this.specialMode,
      draggingCoin: draggingCoin ?? this.draggingCoin,
    );
  }
}
