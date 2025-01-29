import 'package:flutter/material.dart';
import 'package:mood_journal/core/injection.dart';
import 'package:mood_journal/core/mood_journal_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MoodJournalApp());
}

