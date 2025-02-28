import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mood_journal/core/constants/feelings_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/feeling/feeling_model.dart';
import 'package:mood_journal/core/repository/mood_journal_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'feelings_event.dart';

part 'feelings_state.dart';

class FeelingsBloc extends Bloc<FeelingsEvent, FeelingsState> {
  FeelingsBloc() : super(FeelingsState.initial()) {
    on<FeelingsInitialEvent>(_initial);
    on<FeelingsSelectFeelingEvent>(_selectFeeling);
    on<FeelingsClearCurrentEvent>(_clearCurrent);
  }

  FutureOr<void> _initial(
      FeelingsInitialEvent event, Emitter<FeelingsState> emit) async {
    emit(state.copyWith(
      status: FeelingsStatus.loading,
    ));

    try {
      List<FeelingModel> listFeelings =
          await getIt<MoodJournalRepository>().getFeelings();

      emit(state.copyWith(
        status: FeelingsStatus.success,
        listFeelings: listFeelings,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: FeelingsStatus.error,
      ));
    }
  }

  void _selectFeeling(
      FeelingsSelectFeelingEvent event, Emitter<FeelingsState> emit) {
    emit(state.copyWith(
      status: FeelingsStatus.selecting,
    ));

    try {
      emit(state.copyWith(
        status: FeelingsStatus.success,
        currentFeeling: event.feeling,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: FeelingsStatus.error,
      ));
    }
  }

  void _clearCurrent(
      FeelingsClearCurrentEvent event, Emitter<FeelingsState> emit) {

    try {
      emit(state.copyWith(
        status: FeelingsStatus.success,
        currentFeeling: null,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: FeelingsStatus.error,
      ));
    }
  }
}
