part of 'save_data_bloc.dart';

class SaveDataState extends Equatable {
  final SaveDataStatus status;
  final FeelingModel? feeling;
  final List<TagModel> tags;
  final double stressLevel;
  final double selfAssessment;
  final String note;
  final DateTime? dateTime;

  SaveDataState._({
    required this.status,
    required this.feeling,
    required this.tags,
    required this.stressLevel,
    required this.selfAssessment,
    required this.note,
    required this.dateTime,
  });

  factory SaveDataState.initial() {
    return SaveDataState._(
      status: SaveDataStatus.initial,
      feeling: null,
      tags: [],
      stressLevel: -1,
      selfAssessment: -1,
      note: '',
      dateTime: null,
    );
  }

  SaveDataState copyWith({
    SaveDataStatus? status,
    FeelingModel? feeling,
    List<TagModel>? tags,
    double? stressLevel,
    double? selfAssessment,
    String? note,
    DateTime? dateTime,
  }) {
    return SaveDataState._(
      status: status ?? this.status,
      feeling: feeling ?? this.feeling,
      tags: tags ?? this.tags,
      stressLevel: stressLevel ?? this.stressLevel,
      selfAssessment: selfAssessment ?? this.selfAssessment,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  List<Object?> get props => [
        status,
        feeling,
        tags,
        stressLevel,
        selfAssessment,
        note,
        dateTime,
      ];
}
