import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/core/constants/const.dart';
import 'package:mood_journal/core/constants/save_data_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/feeling/feeling_model.dart';
import 'package:mood_journal/core/model/tags/tag_model.dart';
import 'package:mood_journal/core/services/date_service.dart';
import 'package:mood_journal/features/main_page/feelings/bloc/feelings_bloc.dart';
import 'package:mood_journal/features/main_page/feelings/view/widgets/feelings_widget.dart';
import 'package:mood_journal/features/main_page/save_data_bloc/save_data_bloc.dart';
import 'package:mood_journal/features/main_page/tags/bloc/tags_bloc.dart';
import 'package:mood_journal/features/main_page/tags/view/widgets/tags_widget.dart';
import 'package:mood_journal/features/main_page/view/widgets/custom_slider.dart';
import 'package:mood_journal/features/main_page/view/widgets/notes_text_field.dart';

class JournalPage extends StatefulWidget {
  final DateTime dateTime;

  JournalPage({super.key, required this.dateTime});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _notesController = TextEditingController();

  double _stressLevel = Const.defaultStressLevel;
  double _selfAssessment = Const.defaultSelfAssessment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),

          // Чувства
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Что чувствуешь?',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FeelingsWidget(),

          SizedBox(
            height: 20,
          ),

          // Теги
          BlocBuilder<FeelingsBloc, FeelingsState>(builder: (context, state) {
            return state.currentFeeling != null
                ? TagsWidget()
                : SizedBox(
                    height: 0,
                  );
          }),

          SizedBox(
            height: 36,
          ),

          // Уровень стресса
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Уровень стресса',
                style: theme.textTheme.bodyLarge,
              )),
          SizedBox(
            height: 20,
          ),
          CustomSlider(
            value: _stressLevel,
            min: 0,
            max: 10,
            divisions: 10,
            minTitle: 'Низкий',
            maxTitle: 'Высокий',
            onChanged: (value) {
              setState(() {
                _stressLevel = value;
              });
            },
          ),

          SizedBox(
            height: 36,
          ),
          // Самооценка
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Самооценка',
                style: theme.textTheme.bodyLarge,
              )),
          SizedBox(
            height: 20,
          ),
          CustomSlider(
            value: _selfAssessment,
            min: 0,
            max: 10,
            divisions: 10,
            minTitle: 'Неуверенность',
            maxTitle: 'Увереннность',
            onChanged: (newValue) {
              setState(() {
                _selfAssessment = newValue;
              });
            },
          ),

          SizedBox(
            height: 36,
          ),

          // Заметки
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Заметки',
                style: theme.textTheme.bodyLarge,
              )),
          SizedBox(
            height: 20,
          ),
          NotesTextField(
            controller: _notesController,
          ),

          // Кнопка сохранить

          BlocListener<SaveDataBloc, SaveDataState>(
            listener: (context, state) {
              if (state.status == SaveDataStatus.success) {
                // Очистить экран.
                _clearScreen();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Успешно'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state.status == SaveDataStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Произошла ошибка'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: theme.primaryColor,
                  minimumSize: Size(double.infinity, 44)),
              onPressed: _saveData,
              child: Text(
                'Сохранить',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  void _clearScreen() {
    getIt<FeelingsBloc>().add(FeelingsClearCurrentEvent());
    getIt<TagsBloc>().add(TagsClearSelectedTagsEvent());

    setState(() {
      _stressLevel = Const.defaultStressLevel;
      _selfAssessment = Const.defaultSelfAssessment;

      _notesController.text = '';
    });
  }

  void _saveData() {
    FeelingModel? feeling = getIt<FeelingsBloc>().state.currentFeeling;
    String note = _notesController.text.trim();
    List<TagModel> allTags = getIt<TagsBloc>().state.listTags;
    List<bool> selectedTags = getIt<TagsBloc>().state.listSelectedTags;

    List<TagModel> tags = [];

    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags[i]) {
        tags.add(allTags[i]);
      }
    }

    if (feeling != null && note != '') {
      getIt<SaveDataBloc>().add(SaveDataInDatabaseEvent(
        feeling: feeling,
        tags: tags,
        stressLevel: _stressLevel,
        selfAssessment: _selfAssessment,
        note: note,
        dateTime: widget.dateTime,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не все поля были заполнены'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
