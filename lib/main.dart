import 'package:aplikasi_notes/model/notes.dart';
import 'package:aplikasi_notes/ui/list_notes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      home: ListNotesPage(),
    );
  }
}
