import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/services/date_service.dart';
import 'package:mood_journal/features/main_page/feelings/bloc/feelings_bloc.dart';
import 'package:mood_journal/features/main_page/feelings/view/widgets/feelings_widget.dart';
import 'package:mood_journal/features/main_page/tags/view/widgets/tags_widget.dart';
import 'package:mood_journal/features/main_page/view/widgets/custom_slider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DateService dateService = DateService();

  double _stressLevel = 0;
  double _selfAssessment = 0;

  late DateTime dateTime;

  String dateString = '';

  @override
  void initState() {
    dateTime = DateTime.now();

    dateString =
        '${dateTime.day} ${dateService.getStringMonth(dateTime.month)} ${dateTime.hour}:${dateTime.minute}';

    super.initState();
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
              //Переключатель
              ToggleButtons(
                children: [
                  Text('Дневник настроения'),
                  Text('Статистика'),
                ],
                isSelected: [true, false],
                fillColor: theme.primaryColor,
                onPressed: (int index) {},
                borderRadius: BorderRadius.circular(47),
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Здесь будет заметка'),
              ),

              // Кнопка сохранить
              ElevatedButton(onPressed: () {}, child: Text('Сохранить'))
            ],
          ),
        ),
      ),
    );
  }
}
