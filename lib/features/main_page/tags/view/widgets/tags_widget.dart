import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/core/constants/tags_status.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/features/main_page/tags/bloc/tags_bloc.dart';
import 'package:mood_journal/features/main_page/tags/view/widgets/new_tag_widget.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        if (state.status == TagsStatus.gettingAllTags) {
          return CircularProgressIndicator();
        } else if (state.status == TagsStatus.error) {
          return Text('Что то пошло не так...');
        } else {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...List.generate(state.listTags.length, (index) {
                return GestureDetector(
                  onTap: () {
                    getIt<TagsBloc>().add(TagsToggleTagEvent(index: index));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    decoration: BoxDecoration(
                      color: state.listSelectedTags[index] == true
                          ? theme.primaryColor
                          : Colors.white,
                    ),
                    child: Text('${state.listTags?[index].name}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: state.listSelectedTags[index] == true
                              ? Colors.white
                              : Colors.black,
                        ),
                        // TextStyle(
                        //   color: state.listSelectedTags[index] == true
                        //       ? Colors.white
                        //       : Colors.black,
                        //   fon
                        // ),
                        ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () {
                  _addTag(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: theme.primaryColor,
                    ),
                  ),
                  child: Text('Добавить тег +'),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void _addTag(BuildContext context) {
    showDialog(context: context, builder: (context) => NewTagWidget());
  }
}
