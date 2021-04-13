import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mooday/bloc/mooday/track_bloc.dart';
import 'package:mooday/constant.dart';
import 'package:mooday/models/track_model.dart';
import 'package:mooday/provider/api_provider.dart';
import 'package:mooday/repository/mooday_repository.dart';
import 'package:mooday/screens/home_screen.dart';

void main() {
  runApp(MyApp());
  // 128 weeks and still counting
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MoodayRepository>(
          create: (context) => MoodayRepository(),
          lazy: true,
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider  (
        providers: [
          BlocProvider<TrackBloc>(
            create: (context)  => TrackBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Mooday',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme.apply(bodyColor: colorText)),
            accentColor: Color(0xFFDBCFF9),
            primaryColor: Color(0xFF9B51E0), 
            backgroundColor: Color(0xFFF6F6F8)
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}