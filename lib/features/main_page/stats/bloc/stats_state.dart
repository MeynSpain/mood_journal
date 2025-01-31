part of 'stats_bloc.dart';

class StatsState extends Equatable {
  final StatsStatus status;
  final List<JournalModel> journals;
  final Map<int, double> stressLevelMap;
  final Map<int, double> selfAssessmentMap;

  StatsState._({
    required this.status,
    required this.journals,
    required this.stressLevelMap,
    required this.selfAssessmentMap,
  });

  factory StatsState.initial() => StatsState._(
        status: StatsStatus.initial,
        journals: [],
        selfAssessmentMap: {},
        stressLevelMap: {},
      );

  StatsState copyWith({
    StatsStatus? status,
    List<JournalModel>? journals,
    Map<int, double>? stressLevelMap,
    Map<int, double>? selfAssessmentMap,
  }) {
    return StatsState._(
      status: status ?? this.status,
      journals: journals ?? this.journals,
      stressLevelMap: stressLevelMap ?? this.stressLevelMap,
      selfAssessmentMap: selfAssessmentMap ?? this.stressLevelMap,
    );
  }

  @override
  List<Object?> get props => [
        status,
        journals,
        stressLevelMap,
        selfAssessmentMap,
      ];
}
