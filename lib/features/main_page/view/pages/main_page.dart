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
import 'package:mood_journal/features/main_page/view/pages/journal_page.dart';
import 'package:mood_journal/features/main_page/view/pages/stats_page.dart';
import 'package:mood_journal/features/main_page/view/widgets/custom_slider.dart';
import 'package:mood_journal/features/main_page/view/widgets/notes_text_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _openPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  final DateService dateService = DateService();

  late DateTime dateTime;

  String dateString = '';

  // int selectedIndex = 0;

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
    _pageController.dispose();
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
            Expanded(
              child: PageView(
                onPageChanged: _onPageChanged,
                controller: _pageController,
                children: [
                  JournalPage(
                    dateTime: dateTime,
                  ),
                  StatsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    bool isSelected = _selectedPageIndex == index;
    final theme = Theme.of(context);
    return Transform.translate(
      offset: Offset(offset, 0), // Смещение кнопок для перекрытия
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPageIndex = index;
            _openPage(index);
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
