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

  Future<void> _getJournals(StatsGetJournalsEvent event,
      Emitter<StatsState> emit) async {
    emit(state.copyWith(
      status: StatsStatus.loading,
    ));

    try {
      List<JournalModel> journals = await getIt<MoodJournalRepository>()
          .getJournalByDate(event.startDate, event.endDate);

      Map<int, List<int>> _stressMap = {};
      Map<int, List<int>> _selfAssessmentMap = {};

      for (var record in journals) {
        int hour = record.date!.hour;

        // Если ключа нет, создаём новый список
        if (!_stressMap.containsKey(hour)) {
          _stressMap[hour] = [];
        }
        _stressMap[hour]!.add(record.stressLevel!);

        if (!_selfAssessmentMap.containsKey(hour)) {
          _selfAssessmentMap[hour] = [];
        }
        _selfAssessmentMap[hour]!.add(record.selfAssessment!);
      }

      Map<int, double> _stressLevelMap = {};
      Map<int, double> _selfAssessmentLevelMap = {};

      _stressLevelMap = _stressMap.map((key, value) {
        double avg = value.reduce((a, b) => a + b) / value.length;
        avg = double.parse(avg.toStringAsFixed(2));
        return MapEntry(key, avg);
      });

      _selfAssessmentLevelMap = _selfAssessmentMap.map((key, value) {
        double avg = value.reduce((a, b) => a + b) / value.length;
        avg = double.parse(avg.toStringAsFixed(2));
        return MapEntry(key, avg);
      });

      emit(state.copyWith(
        status: StatsStatus.success,
        journals: journals,
        stressLevelMap: _stressLevelMap,
        selfAssessmentMap: _selfAssessmentLevelMap,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: StatsStatus.error,
      ));
    }
  }
}
