import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DateService dateService = DateService();
  final TextEditingController _notesController = TextEditingController();

  double _stressLevel = Const.defaultStressLevel;
  double _selfAssessment = Const.defaultSelfAssessment;

  late DateTime dateTime;

  String dateString = '';

  int selectedIndex = 0;

  double correctOffset = 28;

  @override
  void initState() {
    dateTime = DateTime.now();

    dateString =
        '${dateTime.day} ${dateService.getStringMonth(dateTime.month)} ${dateTime.hour}:${dateTime.minute}';

    super.initState();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dateString,
          style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFFBCBCBF)),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.date_range_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  _buildBackground(), // Фон переключателя
                  _buildToggleButton(0, 'Дневник настроения', Const.journal,
                      theme.primaryColor, (-86 - 1) + correctOffset),
                  _buildToggleButton(1, 'Статистика', Const.stats,
                      theme.primaryColor, (58 + 1) + correctOffset),
                ],
              ),

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
              BlocBuilder<FeelingsBloc, FeelingsState>(
                  builder: (context, state) {
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
        ),
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
        dateTime: dateTime,
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

  Widget _buildBackground() {
    return Container(
      height: 30 + 8,
      width: 290,
      // padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(47),
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildToggleButton(int index, String text, String imagePath,
      Color activeColor, double offset) {
    bool isSelected = selectedIndex == index;
    final theme = Theme.of(context);
    return Transform.translate(
      offset: Offset(offset, 0), // Смещение кнопок для перекрытия
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9, horizontal: 17),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(47),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Кнопки подстраиваются под контент
            children: [
              Image.asset(
                imagePath,
                color: isSelected ? Colors.white : Colors.grey,
              ),
              SizedBox(width: 8),
              Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Color(0xFFBCBCBF)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
