import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/core/services/date_service.dart';
import 'package:mood_journal/features/main_page/feelings/view/widgets/feelings_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DateService dateService = DateService();

  double _stressLevel = 0;

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
        title: Text(dateString),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.date_range_rounded)),
        ],
      ),
      body: Column(
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
          Text('Что чувствуешь?'),
          Expanded(child: FeelingsWidget()),

          // Теги

          Expanded(child: Text('Тэги')),

          // Уровень стресса
          Expanded(
            child: Column(
              children: [
                Text('Уровень стресса'),
                Text('Тут должны быть метки'),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: theme.primaryColor,
                    activeTickMarkColor: theme.primaryColor,
                    inactiveTrackColor: theme.primaryColor.withAlpha(10),
                    inactiveTickMarkColor: theme.primaryColor.withAlpha(10),
                    trackHeight: 10,
                    thumbColor: theme.primaryColor,
                    overlayColor: theme.primaryColor.withAlpha(100),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: theme.primaryColor,
                    valueIndicatorTextStyle: TextStyle(color: Colors.white),
                    trackShape: RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(
                    value: _stressLevel,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: _stressLevel.toString(),
                    onChanged: (value) {
                      setState(
                        () {
                          _stressLevel = value;
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Низкий', style: TextStyle(fontSize: 16)),
                    Text('Высокий', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),

          // Самооценка
          Expanded(
            child: Column(
              children: [
                Text('Самооценка'),
                Text('Тут должны быть метки'),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: theme.primaryColor,
                    activeTickMarkColor: theme.primaryColor,
                    inactiveTrackColor: theme.primaryColor.withAlpha(10),
                    inactiveTickMarkColor: theme.primaryColor.withAlpha(10),
                    trackHeight: 10,
                    thumbColor: theme.primaryColor,
                    overlayColor: theme.primaryColor.withAlpha(100),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: theme.primaryColor,
                    valueIndicatorTextStyle: TextStyle(color: Colors.white),
                    trackShape: RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(
                    value: _stressLevel,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: _stressLevel.toString(),
                    onChanged: (value) {
                      setState(
                        () {
                          _stressLevel = value;
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Неуверенность', style: TextStyle(fontSize: 16)),
                    Text('Уверенность', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),

          // Заметки
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Здесь будет заметка'),
            ),
          ),

          // Кнопка сохранить
          Expanded(
              child: ElevatedButton(onPressed: () {}, child: Text('Сохранить')))
        ],
      ),
    );
  }
}
