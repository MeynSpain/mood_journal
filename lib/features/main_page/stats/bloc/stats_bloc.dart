import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mood_journal/core/constants/stats_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/journal/journal_model.dart';
import 'package:mood_journal/core/repository/mood_journal_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'stats_event.dart';

part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc() : super(StatsState.initial()) {
    on<StatsGetJournalsEvent>(_getJournals);
  }

  Future<void> _getJournals(
      StatsGetJournalsEvent event, Emitter<StatsState> emit) async {
    emit(state.copyWith(
      status: StatsStatus.loading,
    ));

    try {
      List<JournalModel> journals = await getIt<MoodJournalRepository>()
          .getJournalByDate(event.startDate, event.endDate);

      emit(state.copyWith(
        status: StatsStatus.success,
        journals: journals,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: StatsStatus.error,
      ));
    }
  }
}
