import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/core/constants/feelings_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/features/main_page/feelings/bloc/feelings_bloc.dart';

class FeelingsWidget extends StatelessWidget {
  const FeelingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 122,
      child: BlocBuilder<FeelingsBloc, FeelingsState>(
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
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    // width: 83,
                    // height: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(76),
                      border: Border.all(
                        width: 2,
                        color:  state.currentFeeling?.id == index + 1
                            ? theme.primaryColor
                            : Colors.white
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15, top: 23, right: 15,),
                          child: Image.asset(
                            feeling.path ?? 'assets/images/moods/sad.svg',
                            width: 53,
                            height: 50,

                          ),
                        ),
                        Text(feeling.name ?? 'Название потерялось', style: theme.textTheme.bodySmall,),
                      ],
                    ),
                  ),
                  onTap: () {
                    if (state.currentFeeling != feeling) {
                      getIt<FeelingsBloc>()
                          .add(FeelingsSelectFeelingEvent(feeling: feeling));
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
