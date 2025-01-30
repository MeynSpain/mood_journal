part of 'save_data_bloc.dart';

@immutable
abstract class SaveDataEvent {}

class SaveDataInDatabaseEvent extends SaveDataEvent {
  final FeelingModel feeling;
  final List<TagModel> tags;
  final double stressLevel;
  final double selfAssessment;
  final String note;
  final DateTime dateTime;

  SaveDataInDatabaseEvent({
    required this.feeling,
    required this.tags,
    required this.stressLevel,
    required this.selfAssessment,
    required this.note,
    required this.dateTime,
  });
}
