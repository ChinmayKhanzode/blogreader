import 'dart:io';
import 'package:blogviewer/screens/bloglist.dart';
import 'package:blogviewer/screens/downloadScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogs',
      home: BlogList(),
    );
  }
}
