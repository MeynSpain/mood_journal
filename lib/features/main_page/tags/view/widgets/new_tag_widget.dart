import 'package:flutter/material.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/model/tags/tag_model.dart';
import 'package:mood_journal/features/main_page/tags/bloc/tags_bloc.dart';

class NewTagWidget extends StatefulWidget {
  const NewTagWidget({super.key});

  @override
  State<NewTagWidget> createState() => _NewTagWidgetState();
}

class _NewTagWidgetState extends State<NewTagWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 150,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text('Добавить тег'),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {
                        String text = _textEditingController.text.trim();

                        if (text != '') {
                          TagModel tag = TagModel(
                            name: text,
                          );

                          getIt<TagsBloc>().add(TagsAddTagEvent(
                            tagModel: tag,
                          ));

                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
