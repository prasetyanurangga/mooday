import 'package:flutter/material.dart';
import 'package:mooday/screens/get_mood_screen.dart';
import 'package:mooday/screens/get_track_screen.dart';
import 'package:mooday/screens/result_mood_screen.dart';
import 'package:mooday/screens/result_track_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => GetTrackScreen());
      break;
    case "/result_track":
      return MaterialPageRoute(builder: (context) => ResultTrackScreen());
      break; 
    case "/result_mood":
      return MaterialPageRoute(builder: (context) => ResultMoodScreen());
      break;
    case "/get_mood":
      return MaterialPageRoute(builder: (context) => GetMoodScreen());
      break;  
    // case contentGenrePageRoute:
    //   final typedArgs = args as ContentGenrePageArguments ?? ContentGenrePageArguments();
    //   return MaterialPageRoute(builder: (context) => ContentGenrePage(genreId: typedArgs.genreId, genreName: typedArgs.genreName));
    //   break;   
    default:
      return MaterialPageRoute(builder: (context) => GetTrackScreen());
  }
}

// class DetailContentPageArguments {
//   final int id;
//   final TypeContent type;
//   DetailContentPageArguments({this.id, this.type});
// }
