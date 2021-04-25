import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooday/bloc/track/track_bloc.dart';
import 'package:mooday/bloc/track/track_event.dart';
import 'package:mooday/bloc/track/track_state.dart';
import 'package:mooday/bloc/mood/mood_bloc.dart';
import 'package:mooday/bloc/mood/mood_event.dart';
import 'package:mooday/bloc/mood/mood_state.dart';
import 'package:mooday/component/hover_button.dart';
import 'package:mooday/component/slider_mood.dart';
import 'package:mooday/constant.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _counter = "0";
  double moodValue = 0.0;
  String categoryButtonActive = "track";
  PageController _pageController = PageController(
    initialPage: 0,
  );
  TextEditingController _searchController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    setState((){
        _counter = "initState";
    });
  }

  void setValueSlider(String index, double min, double max) {
    Map<String, double> temp = mapValue;

    temp[index+"_from"] = min;
    temp[index+"_to"] = max;

    setState(() => mapValue = temp);
  }

  void _incrementCounter() async {
    setState((){
        _counter = "seconds";
    });
    var authenticationToken = await SpotifySdk.getAuthenticationToken(clientId: client_id, redirectUrl: redirect_uri, scope: "app-remote-control,user-modify-playback-state,playlist-read-private");
    setState((){
      _counter = authenticationToken;
    });
  }

  void onClickKategori(id) {
    setState(() => categoryButtonActive = id);
  }

  void _launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              children:[
                Text(
                  "MooDay", 
                  textAlign: TextAlign.center, 
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: colorPrimary,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Search Your music by mood\nThe music is classified using Spotify's audio feature", textAlign: TextAlign.center
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: (){
                        _pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
                        onClickKategori("track");
                      },
                      child: HoverButton(
                        title: "Get Track",
                        isActive: categoryButtonActive == "track",
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: (){
                        _pageController.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
                        onClickKategori("mood");
                      },
                      child : HoverButton(
                        title: "Get Mood",
                        isActive: categoryButtonActive == "mood",
                      )
                    ),
                  ]
                ),
                SizedBox(height: 50),
                SizedBox(
                  height: 640,
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Container(
                              width: 450,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: boxShadow,
                              ),
                              child: Column(
                                children:[
                                  Text(
                                    "What's your mood?",
                                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 19, fontWeight: FontWeight.bold)
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500].withOpacity(.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:32),
                                    child: Column(
                                      children:[
                                        
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
                                  ),
                                  SizedBox(height: 20),
                                  OutlinedButton(
                                    onPressed: (){
                                      BlocProvider.of<TrackBloc>(context).add(
                                        GetTrackByMood(
                                            data: mapValue
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor),borderRadius: BorderRadius.circular(30.0))),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Get Song",
                                        style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor)
                                      ),
                                    ),
                                  )

                                ]
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                height: 250,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: boxShadow,
                                ),
                                child: BlocBuilder<TrackBloc, TrackState>(
                                  builder: (context, state){
                                    if(state is TrackLoading){
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    else if(state is TrackSuccess) {
                                      var data = state.trackModel;
                                      if(data.length > 0) {
                                        return GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 8,
                                              crossAxisSpacing: 8,
                                              childAspectRatio: (MediaQuery.of(context).size.width/2)/180.0,
                                          ),
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext ctx, index) {
                                            return Container(
                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _launchURL(data[index].spotifyUrl);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        child: CachedNetworkImage(
                                                          width: 50,
                                                          height: 50,
                                                            imageUrl: data[index].imageCover,
                                                            placeholder: (context, url) => CircularProgressIndicator(),
                                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),

                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                data[index].name, 
                                                                textAlign: TextAlign.left,
                                                                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 17, fontWeight: FontWeight.bold)
                                                              ),
                                                              Text(
                                                                data[index].artist, 
                                                                textAlign: TextAlign.left,
                                                                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 15)
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ]
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      } else {
                                        return Center(
                                          child: Text(
                                            "Nothing to show here",
                                            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[500])
                                          )
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: Text(
                                          "Nothing to show here",
                                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[500])
                                        )
                                      );
                                    }
                                  }
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[

                            Expanded(
                              child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: boxShadow,
                              ),
                              child: Column(
                                children:[
                                  Text(
                                    "What's your track?",
                                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 19, fontWeight: FontWeight.bold)
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500].withOpacity(.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:32),
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Spotify Url'
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  OutlinedButton(
                                    onPressed: (){
                                      BlocProvider.of<MoodBloc>(context).add(
                                        GetMoodByTrack(
                                          url : _searchController.text
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).primaryColor),borderRadius: BorderRadius.circular(30.0))),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Get Mood",
                                        style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor)
                                      ),
                                    ),
                                  )

                                ]
                              ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 450,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: boxShadow,
                              ),
                              child: BlocBuilder<MoodBloc, MoodState>(
                                builder: (context, state){
                                  if(state is MoodLoading){
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  else if(state is MoodSuccess) {
                                    var data = state.audioFeatureModel;
                                    var track = state.audioTrackModel;
                                    var artistName = track.artists.length > 0 ? track.artists[0].name+" : " : "";
                                    return Column(
                                      children:[
                                        Text(
                                          artistName+track.name,
                                          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 19, fontWeight: FontWeight.bold)
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[500].withOpacity(.5),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:32),
                                          child: Column(
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
                                        ),
                                      ]
                                    );
                                  } else if(state is MoodFailure) {
                                    // print(state.error);
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
                          ],
                        ),
                      )
                    ]
                  ),
                ),
              ]
            )
          )
        )
      )  
    );
  }

}



