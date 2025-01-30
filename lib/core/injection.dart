import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mood_journal/core/constants/prefs_names.dart';
import 'package:mood_journal/core/repository/mood_journal_repository.dart';
import 'package:mood_journal/features/main_page/feelings/bloc/feelings_bloc.dart';
import 'package:mood_journal/features/main_page/save_data_bloc/save_data_bloc.dart';
import 'package:mood_journal/features/main_page/tags/bloc/tags_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Инстанс [GetIt]
final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Talker init
  final talker = TalkerFlutter.init();
  getIt.registerSingleton(talker);
  getIt<Talker>().info('Application started...');

  //Talker bloc logger
  Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
        printEventFullData: false,
        printStateFullData: true,
      ));

  MoodJournalRepository moodJournalRepository = MoodJournalRepository();
  getIt.registerSingleton(moodJournalRepository);

  // Prefs
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton(prefs);

  final isFirstLaunch = prefs.getBool(PrefsNames.isFirstLaunch) ?? true;

  if (isFirstLaunch) {
    // Заполнить БД начальными данными
    await moodJournalRepository.insertInitialData();

    // Флаг о первом запуске ставим false
    prefs.setBool(PrefsNames.isFirstLaunch, false);
  }
  // await moodJournalRepository.update();

  // FeelingsBloc
  getIt.registerLazySingleton(() => FeelingsBloc());
  getIt<FeelingsBloc>().add(FeelingsInitialEvent());

  // TagsBloc
  getIt.registerLazySingleton(() => TagsBloc());
  getIt<TagsBloc>().add(TagsGetAllTagsEvent());

  // SaveDataBloc
  getIt.registerLazySingleton(() => SaveDataBloc());
}
