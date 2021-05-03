import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooday/bloc/mood/mood_bloc.dart';
import 'package:mooday/bloc/mood/mood_state.dart';
import 'package:mooday/bloc/track/track_bloc.dart';
import 'package:mooday/bloc/track/track_state.dart';
import 'package:mooday/component/slider_mood.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultMoodScreen extends StatefulWidget {
  ResultMoodScreen({Key key}) : super(key: key);

  @override
  _ResultMoodScreenState createState() => _ResultMoodScreenState();
}

class _ResultMoodScreenState extends State<ResultMoodScreen> {

  Map<String, double> mapValue = {
    "mood_from" : 0.0,
    "mood_to" : 1.0,
    "acousticness_from" : 0.0,
    "acousticness_to" : 1.0,
    "instrumentalness_from" : 0.0,
    "instrumentalness_to" : 1.0,
    "energy_from" : 0.0,
    "energy_to" : 1.0,
    "danceability_from" : 0.0,
    "danceability_to" : 1.0,
    "valence_from" : 0.0,
    "valence_to": 1.0
  };

  void setValueSlider(String index, double min, double max) {
    Map<String, double> temp = mapValue;

    temp[index+"_from"] = min;
    temp[index+"_to"] = max;

    setState(() => mapValue = temp);
  }

  void _launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(24),
        child: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state){
            if(state is MoodLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            else if(state is MoodSuccess) {
              var data = state.audioFeatureModel;
              var track = state.audioTrackModel;
              var artistName = track.artists.length > 0 ? track.artists[0].name+" : " : "";
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      artistName+track.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24, fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children:[
                      AbsorbPointer(
                        child: SliderMood(
                          firstIcon: "assets/icons/bad_mood.png",
                          lastIcon: "assets/icons/good_mood.png",
                          title: "Mood",
                          id: "mood",
                          value: data.liveness,
                          onChange: setValueSlider,
                        ),
                      ),

                      AbsorbPointer(
                        child: SliderMood(
                          firstIcon: "assets/icons/akustik_analog.png",
                          lastIcon: "assets/icons/akustik_digital.png",
                          title: "Acousticness",
                          id: "acousticness",
                          value: data.acousticness,
                          onChange: setValueSlider,
                        ),
                      ),

                      AbsorbPointer(
                        child: SliderMood(
                          firstIcon: "assets/icons/vocal.png",
                          lastIcon: "assets/icons/instrumental.png",
                          title: "Instrumentalness",
                          id: "instrumentalness",
                          value: data.instrumentalness,
                          onChange: setValueSlider,
                        ),
                      ),

                      AbsorbPointer(
                        child: SliderMood(
                          firstIcon: "assets/icons/no_dance.png",
                          lastIcon: "assets/icons/dance.png",
                          title: "Danceability",
                          id: "danceability",
                          value: data.danceability,
                          onChange: setValueSlider,
                        ),
                      ),

                      AbsorbPointer(
                        child: SliderMood(
                          firstIcon: "assets/icons/calm.png",
                          lastIcon: "assets/icons/energy.png",
                          title: "Energy",
                          id: "energy",
                          value: data.energy,
                          onChange: setValueSlider,
                        ),
                      ),

                    ]
                  ),
                ]
              );
            } else if(state is MoodFailure) {
              print(state.error);
              return Center(
                child: Text(
                  "Nothing to show here",
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[500])
                )
              );
            } else {
              return Center(
                child: Text(
                  "Nothing to show here",
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[500])
                )
              );
            }
          }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
       body: _buildBody(),
    );
  }
}