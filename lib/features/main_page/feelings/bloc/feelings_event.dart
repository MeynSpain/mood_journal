part of 'feelings_bloc.dart';

@immutable
abstract class FeelingsEvent {}

class FeelingsInitialEvent extends FeelingsEvent {}

class FeelingsSelectFeelingEvent extends FeelingsEvent {
  final FeelingModel feeling;

  FeelingsSelectFeelingEvent({required this.feeling});
}

class FeelingsClearCurrentEvent extends FeelingsEvent {}