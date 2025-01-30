import 'package:flutter/material.dart';

class NotesTextField extends StatefulWidget {
  final TextEditingController controller;

  NotesTextField({super.key, required this.controller});

  @override
  State<NotesTextField> createState() => _NotesTextFieldState();
}

class _NotesTextFieldState extends State<NotesTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 90,
      child: TextField(
        controller: widget.controller,
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Color(0XFF4C4C69),
        ),
        decoration: InputDecoration(
          hintText: 'Введите заметку',
          hintStyle:
              theme.textTheme.bodyMedium?.copyWith(color: Color(0xFFBCBCBF)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
