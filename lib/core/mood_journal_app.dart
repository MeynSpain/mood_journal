import 'package:flutter/material.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/routes/routes.dart';
import 'package:mood_journal/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/features/main_page/feelings/bloc/feelings_bloc.dart';
import 'package:mood_journal/features/main_page/save_data_bloc/save_data_bloc.dart';
import 'package:mood_journal/features/main_page/tags/bloc/tags_bloc.dart';

class MoodJournalApp extends StatelessWidget {
  const MoodJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<FeelingsBloc>()),
        BlocProvider(create: (context) => getIt<TagsBloc>()),
        BlocProvider(create: (context) => getIt<SaveDataBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: mainTheme,
      ),
    );
  }
}
