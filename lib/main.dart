import 'package:flutter/material.dart';
import 'package:note_app/screens/add_new_note.dart';
import 'package:note_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeScreen(),
      routes: {"addnotes":(context)=>addNote()},
    );
  }
}
