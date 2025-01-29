import 'package:equatable/equatable.dart';
import 'package:mood_journal/core/model/model_mood_journal.dart';

class TagModel extends Equatable {
  int? id;
  String? name;

  TagModel({
    this.id,
    this.name,
  });

  factory TagModel.fromDB({required Tags tag}) {
    return TagModel(
      id: tag.id,
      name: tag.name,
    );
  }

  @override
  String toString() {
    return 'TagModel{id: $id, name: $name}';
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
