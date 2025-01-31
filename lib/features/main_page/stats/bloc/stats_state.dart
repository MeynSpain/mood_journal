part of 'stats_bloc.dart';

class StatsState extends Equatable {
  final StatsStatus status;
  final List<JournalModel> journals;

  StatsState._({
    required this.status,
    required this.journals,
  });

  factory StatsState.initial() => StatsState._(
        status: StatsStatus.initial,
        journals: [],
      );

  StatsState copyWith({
    StatsStatus? status,
    List<JournalModel>? journals,
  }) {
    return StatsState._(
        status: status ?? this.status, journals: journals ?? this.journals);
  }

  @override
  List<Object?> get props => [
        status,
        journals,
      ];
}
