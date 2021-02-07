import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mooday/constant.dart';
import 'package:mooday/screens/home_screen.dart';

void main() {
  runApp(MyApp());
  // 128 weeks and still counting
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mooday',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme.apply(bodyColor: colorText)),
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}