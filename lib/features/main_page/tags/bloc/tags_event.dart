part of 'tags_bloc.dart';

@immutable
abstract class TagsEvent {}

class TagsGetAllTagsEvent extends TagsEvent {}

class TagsAddTagEvent extends TagsEvent {
  final TagModel tagModel;

  TagsAddTagEvent({required this.tagModel});
}

class TagsToggleTagEvent extends TagsEvent {
  final int index;

  TagsToggleTagEvent({required this.index});
}
