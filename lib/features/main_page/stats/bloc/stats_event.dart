part of 'stats_bloc.dart';

@immutable
abstract class StatsEvent {}

class StatsGetJournalsEvent extends StatsEvent {
  final DateTime startDate;
  final DateTime endDate;

  StatsGetJournalsEvent({required this.startDate, required this.endDate});
}
