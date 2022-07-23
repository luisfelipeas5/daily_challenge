import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DailyChallengeEvent extends Equatable {}

class DailyChallengeLoadEvent extends DailyChallengeEvent {
  @override
  List<Object?> get props => [];
}

class DailyChallengeSpinEvent extends DailyChallengeEvent {
  @override
  List<Object?> get props => [];
}

class DailyChallengeSpinStoppedEvent extends DailyChallengeEvent {
  @override
  List<Object?> get props => [];
}
