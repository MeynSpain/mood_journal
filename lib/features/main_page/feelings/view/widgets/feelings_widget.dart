import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/core/constants/feelings_status.dart';
import 'package:mood_journal/features/main_page/feelings/bloc/feelings_bloc.dart';

class FeelingsWidget extends StatelessWidget {
  const FeelingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FeelingsBloc, FeelingsState>(
      builder: (context, state) {
        if (state.status == FeelingsStatus.initial) {
          return CircularProgressIndicator(
            color: theme.primaryColor,
          );
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.listFeelings.length,
            itemBuilder: (context, index) {
              final feeling = state.listFeelings[index];
              return Container(
                child: Column(
                  children: [
                    Image.asset(
                      feeling.path ?? 'assets/images/moods/sad.svg',
                    ),
                    Text(feeling.name ?? 'Название потерялось'),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
