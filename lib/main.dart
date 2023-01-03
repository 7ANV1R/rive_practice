import 'package:flutter/material.dart';
import 'package:rive_test/custom_homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomHomePage(),
    );
  }
}
