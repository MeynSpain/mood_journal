import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mood_journal/core/constants/save_data_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/feeling/feeling_model.dart';
import 'package:mood_journal/core/model/model_mood_journal.dart';
import 'package:mood_journal/core/model/tags/tag_model.dart';
import 'package:mood_journal/core/repository/mood_journal_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'save_data_event.dart';

part 'save_data_state.dart';

class SaveDataBloc extends Bloc<SaveDataEvent, SaveDataState> {
  SaveDataBloc() : super(SaveDataState.initial()) {
    on<SaveDataInDatabaseEvent>(_saveData);
  }

  Future<void> _saveData(SaveDataInDatabaseEvent event,
      Emitter<SaveDataState> emit) async {
    emit(state.copyWith(
      status: SaveDataStatus.loading,
    ));

    try {
      await getIt<MoodJournalRepository>().saveDataToJournal(
          feeling: event.feeling,
          tags: event.tags,
          stressLevel: event.stressLevel,
          selfAssessment: event.selfAssessment,
          note: event.note,
          dateTime: event.dateTime);

      emit(state.copyWith(
        dateTime: event.dateTime,
        note: event.note,
        tags: event.tags,
        feeling: event.feeling,
        stressLevel: event.stressLevel,
        selfAssessment: event.selfAssessment,
        status: SaveDataStatus.success,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: SaveDataStatus.error,
      ));
    }
  }
}
