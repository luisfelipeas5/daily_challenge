import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RouletteEvent extends Equatable {}

class RouletteLoadEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteSpinEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteSpinStoppedEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteSuccessDialogCloseEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteFailedDialogCloseEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteAddCoinEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteCoinDraggedEvent extends RouletteEvent {
  @override
  List<Object?> get props => [];
}

class RouletteDraggingCoinEvent extends RouletteEvent {
  final bool dragging;

  RouletteDraggingCoinEvent({
    required this.dragging,
  });

  @override
  List<Object?> get props => [
        dragging,
      ];
}
