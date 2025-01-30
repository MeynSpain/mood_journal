import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/feeling/feeling_model.dart';
import 'package:mood_journal/core/model/model_mood_journal.dart';
import 'package:mood_journal/core/model/tags/tag_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MoodJournalRepository {
  /// Получение списка чувств из базы данных
  Future<List<FeelingModel>> getFeelings() async {
    List<FeelingModel> listFeelings = [];

    try {
      List<Feelings> feelings = await Feelings().select().toList();

      for (var feeling in feelings) {
        listFeelings.add(FeelingModel.fromDB(feeling: feeling));
      }

      return listFeelings;
    } catch (e, st) {
      getIt<Talker>().handle(e, st);

      getIt<Talker>()
          .info('Произошла ошибка при попытки получить список чувств из бд!');
      return [];
    }
  }

  Future<List<TagModel>> getAllTags() async {
    try {
      List<Tags> tags = await Tags().select().toList();

      List<TagModel> listTagModel = [];
      for (var tag in tags) {
        listTagModel.add(TagModel.fromDB(tag: tag));
      }

      return listTagModel;
    } catch (e, st) {
      getIt<Talker>().handle(e, st);

      getIt<Talker>()
          .info('Произошла ошибка при попытки получить список тегов из бд!');
      return [];
    }
  }

  Future<void> addTag(TagModel tagModel) async {
    Tags tag = Tags();
    tag.name = tagModel.name;
    await tag.save();
  }

  Future<void> saveDataToJournal(
      {required FeelingModel feeling,
      required List<TagModel> tags,
      required double stressLevel,
      required double selfAssessment,
      required String note,
      required DateTime dateTime,
      }) async {
    try {
      Journal journalRecord = Journal();

      String tagsString = tags.join(';');

      journalRecord.id_feeling = feeling.id;
      journalRecord.idTags = tagsString;
      journalRecord.stressLevel = stressLevel.toInt();
      journalRecord.selfAssessment = selfAssessment.toInt();
      journalRecord.date = dateTime;
      journalRecord.note = note;

      journalRecord.save();
    } catch (e, st) {
     getIt<Talker>().handle(e, st);
     getIt<Talker>().error('Не получилось сохранить запись в базу данных');

    }

  }

/*  Svg ни в какую не отображлись пришлось заменить на Png, причем через replace я заменил не то
  Future<void> update() async {
    List<Feelings> feelings = await Feelings().select().toList();
    feelings[0].filePath = 'assets/images/moods/happy.png';
    feelings[1].filePath = 'assets/images/moods/fear.png';
    feelings[2].filePath = 'assets/images/moods/rage.png';
    feelings[3].filePath = 'assets/images/moods/sad.png';
    feelings[4].filePath = 'assets/images/moods/calm.png';
    feelings[5].filePath = 'assets/images/moods/power.png';

    for (var feel in feelings) {
      await feel.save();
    }
  }
   */

  /// Вставка начальных данных в бд
  Future<void> insertInitialData() async {
    // Заполнение таблицы чувств
    await Feelings.withFields('Радость', 'assets/images/moods/happy.png')
        .save();
    await Feelings.withFields('Страх', 'assets/images/moods/fear.png').save();
    await Feelings.withFields('Бешенство', 'assets/images/moods/rage.png')
        .save();
    await Feelings.withFields('Грусть', 'assets/images/moods/sad.png').save();
    await Feelings.withFields('Спокойствие', 'assets/images/moods/calm.png')
        .save();
    await Feelings.withFields('Сила', 'assets/images/moods/power.png').save();

    // Заполнение тегов
    await Tags.withFields('Возбуждение').save();
    await Tags.withFields('Восторг').save();
    await Tags.withFields('Игривость').save();
    await Tags.withFields('Наслаждение').save();
    await Tags.withFields('Очарование').save();
    await Tags.withFields('Осознанность').save();
    await Tags.withFields('Смелость').save();
    await Tags.withFields('Удовольствие').save();
    await Tags.withFields('Чувственность').save();
    await Tags.withFields('Энергичность').save();
    await Tags.withFields('Экстравагантность').save();
  }
}
