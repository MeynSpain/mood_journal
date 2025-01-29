import 'package:equatable/equatable.dart';
import 'package:mood_journal/core/model/model_mood_journal.dart';

class FeelingModel extends Equatable {
  int? id;
  String? name;
  String? path;

  FeelingModel({this.id, this.name, this.path});

  factory FeelingModel.fromDB({required Feelings feeling}) {
    return FeelingModel(
      id: feeling.id,
      name: feeling.name,
      path: feeling.filePath,
    );
  }

  @override
  String toString() {
    return 'FeelingModel{id: $id, name: $name, path: $path}';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        path,
      ];
}
