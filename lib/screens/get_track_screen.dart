import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooday/bloc/track/track_bloc.dart';
import 'package:mooday/bloc/track/track_event.dart';
import 'package:mooday/component/slider_mood.dart';

class GetTrackScreen extends StatefulWidget {
  GetTrackScreen({Key key}) : super(key: key);

  @override
  _GetTrackScreenState createState() => _GetTrackScreenState();
}

class _GetTrackScreenState extends State<GetTrackScreen> {

  Map<String, double> mapValue = {
    "mood_from" : 0.4,
    "mood_to" : 0.6,
    "acousticness_from" : 0.4,
    "acousticness_to" : 0.6,
    "instrumentalness_from" : 0.4,
    "instrumentalness_to" : 0.6,
    "energy_from" : 0.4,
    "energy_to" : 0.6,
    "danceability_from" : 0.4,
    "danceability_to" : 0.6,
    "valence_from" : 0.4,
    "valence_to": 0.6
  };

  void setValueSlider(String index, double min, double max) {
    Map<String, double> temp = mapValue;

    temp[index+"_from"] = min;
    temp[index+"_to"] = max;

    setState(() => mapValue = temp);
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    "What's Your Mood?",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                ),
                SliderMood(
                  firstIcon: "assets/icons/bad_mood.png",
                  lastIcon: "assets/icons/good_mood.png",
                  title: "Mood",
                  id: "mood",
                  value: 0.5,
                  onChange: setValueSlider,
                ),
                SliderMood(
                  firstIcon: "assets/icons/akustik_analog.png",
                  lastIcon: "assets/icons/akustik_digital.png",
                  title: "Acousticness",
                  id: "acousticness",
                  value: 0.5,
                  onChange: setValueSlider,
                ),
                SliderMood(
                  firstIcon: "assets/icons/vocal.png",
                  lastIcon: "assets/icons/instrumental.png",
                  title: "Instrumentalness",
                  id: "instrumentalness",
                  value: 0.5,
                  onChange: setValueSlider,
                ),
                SliderMood(
                  firstIcon: "assets/icons/no_dance.png",
                  lastIcon: "assets/icons/dance.png",
                  title: "Danceability",
                  id: "danceability",
                  value: 0.5,
                  onChange: setValueSlider,
                ),
                SliderMood(
                  firstIcon: "assets/icons/calm.png",
                  lastIcon: "assets/icons/energy.png",
                  title: "Energy",
                  id: "energy",
                  value: 0.5,
                  onChange: setValueSlider,
                ),

              ]
            ),
           
            Column(
              children: [
                ElevatedButton(
                  child: Text(
                    "get track".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    )
                  ),
                  onPressed: () {
                     BlocProvider.of<TrackBloc>(context).add(
                      GetTrackByMood(
                          data: mapValue
                      ),
                    );
                    Navigator.pushNamed(context, "/result_track");
                  }
                ),
                TextButton(
                  child: Text(
                    "Want to find mood?",
                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 14)
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/get_mood");
                  },
                )
              ],
            ),
          ]
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