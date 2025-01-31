import 'package:equatable/equatable.dart';
import 'package:mood_journal/core/model/model_mood_journal.dart';

class JournalModel extends Equatable {
  int? id;
  int? idFeeling;
  DateTime? date;
  String? idTags;
  int? stressLevel;
  int? selfAssessment;
  String? note;

  JournalModel({
    this.id,
    this.idFeeling,
    this.date,
    this.idTags,
    this.stressLevel,
    this.selfAssessment,
    this.note,
  });

  factory JournalModel.fromDB({required Journal journal}) {
    return JournalModel(
      id: journal.id,
      idFeeling: journal.id_feeling,
      date: journal.date,
      idTags: journal.idTags,
      stressLevel: journal.stressLevel,
      selfAssessment: journal.selfAssessment,
      note: journal.note,
    );
  }

  @override
  String toString() {
    return 'JournalModel{id: $id, idFeeling: $idFeeling, date: $date, idTags: $idTags, stressLevel: $stressLevel, selfAssessment: $selfAssessment, note: $note}';
  }

  @override
  List<Object?> get props => [
        id,
        idFeeling,
        date,
        idTags,
        stressLevel,
        selfAssessment,
        note,
      ];
}
