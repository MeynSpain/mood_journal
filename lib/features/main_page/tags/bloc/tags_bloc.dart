import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mood_journal/core/constants/tags_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/tags/tag_model.dart';
import 'package:mood_journal/core/repository/mood_journal_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'tags_event.dart';

part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc() : super(TagsState.initial()) {
    on<TagsGetAllTagsEvent>(_getAllTags);
    on<TagsToggleTagEvent>(_toggleTag);
    on<TagsAddTagEvent>(_addTag);
    on<TagsClearSelectedTagsEvent>(_clearSelectedTags);
  }

  Future<void> _getAllTags(
      TagsGetAllTagsEvent event, Emitter<TagsState> emit) async {
    emit(state.copyWith(status: TagsStatus.gettingAllTags));

    try {
      List<TagModel> tags = await getIt<MoodJournalRepository>().getAllTags();

      List<bool> selectedTags = List.filled(tags.length, false);

      emit(state.copyWith(
        status: TagsStatus.allTagsReceived,
        listTags: tags,
        listSelectedTags: selectedTags,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: TagsStatus.error,
      ));
    }
  }

  void _toggleTag(TagsToggleTagEvent event, Emitter<TagsState> emit) {
    emit(state.copyWith(
      status: TagsStatus.togglingTag,
    ));

    try {
      List<bool> selectedTags = state.listSelectedTags;

      selectedTags[event.index] = !selectedTags[event.index];

      emit(state.copyWith(
        status: TagsStatus.tagToggled,
        listSelectedTags: selectedTags,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(state.copyWith(
        status: TagsStatus.error,
      ));
    }
  }

  Future<void> _addTag(TagsAddTagEvent event, Emitter<TagsState> emit) async {
    emit(state.copyWith(
      status: TagsStatus.addingTag,
    ));

    try {
      await getIt<MoodJournalRepository>().addTag(event.tagModel);

      emit(state.copyWith(
        status: TagsStatus.tagAdded,
        listTags: [...state.listTags, event.tagModel],
        listSelectedTags: [...state.listSelectedTags, true],
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);

      emit(state.copyWith(
        status: TagsStatus.error,
      ));
    }
  }

  void _clearSelectedTags(
      TagsClearSelectedTagsEvent event, Emitter<TagsState> emit) async {

    try {
      List<bool> selectedTags = List.generate(state.listSelectedTags.length, (index) {
        return false;
      });
      print(selectedTags);

      emit(state.copyWith(
        status: TagsStatus.success,
        listSelectedTags: selectedTags,
      ));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);

      emit(state.copyWith(
        status: TagsStatus.error,
      ));
    }
  }
}
