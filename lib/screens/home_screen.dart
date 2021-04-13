import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooday/bloc/mooday/track_bloc.dart';
import 'package:mooday/bloc/mooday/track_event.dart';
import 'package:mooday/bloc/mooday/track_state.dart';
import 'package:mooday/component/hover_button.dart';
import 'package:mooday/component/slider_mood.dart';
import 'package:mooday/constant.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'dart:ui';

import 'package:flutter_wall_layout/flutter_wall_layout.dart';
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
  String categoryButtonActive = "last-month";
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
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
                // SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:[
                //     // RaisedButton(
                //     //   shape: RoundedRectangleBorder(
                //     //     borderRadius: BorderRadius.circular(20.0),
                //     //     side: BorderSide(color: Colors.white)
                //     //   ),
                //     //   color: Colors.white,
                //     //   onPressed:(){},
                //     //   child : Text(
                //     //     "last month"
                //     //   )
                //     // )
                //     GestureDetector(
                //       onTap: (){
                //         onClickKategori("last-month");
                //       },
                //       child : HoverButton(
                //         title: "pertama",
                //         isActive: categoryButtonActive == "last-month",
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     GestureDetector(
                //       onTap: (){
                //         onClickKategori("last-6-month");
                //       },
                //       child: HoverButton(
                //         title: "pertama",
                //         isActive: categoryButtonActive == "last-6-month",
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     GestureDetector(
                //       onTap: (){
                //         onClickKategori("last-time");
                //       },
                //       child : HoverButton(
                //         title: "pertama",
                //         isActive: categoryButtonActive == "last-time",
                //       )
                //     ),
                //   ]
                // ),
                SizedBox(height: 50),
                Row(
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
              ]
            )
          )
        )
      )  
    );
  }

  Widget buildWallLayout() {
    return WallLayout(
      scrollDirection: Axis.horizontal,
      stones: _buildStonesList(),
      reverse: false,
      layersCount: 6,
    );
  }

  List<Stone> _buildStonesList() {
    final data = [
      {"color": Colors.red, "width": 2, "height": 2},
      {"color": Colors.greenAccent, "width": 1, "height": 1},
      {"color": Colors.lightBlue, "width": 1, "height": 2},
      {"color": Colors.purple, "width": 2, "height": 1},
      {"color": Colors.yellow, "width": 1, "height": 1},
      {"color": Colors.cyanAccent, "width": 1, "height": 1},
      {"color": Colors.orange, "width": 2, "height": 2},
      {"color": Colors.green, "width": 1, "height": 1},
      {"color": Colors.pink, "width": 2, "height": 1},
      {"color": Colors.blueAccent, "width": 1, "height": 1},
      {"color": Colors.amber, "width": 1, "height": 2},
      {"color": Colors.teal, "width": 2, "height": 1},
      {"color": Colors.lightGreenAccent, "width": 1, "height": 1},
      {"color": Colors.deepOrange, "width": 1, "height": 1},
      {"color": Colors.deepPurpleAccent, "width": 2, "height": 2},
      {"color": Colors.lightBlueAccent, "width": 1, "height": 1},
      {"color": Colors.limeAccent, "width": 1, "height": 1},
    ];
    return data.map((d) {
      int width = d["width"];
      int height = d["height"];
      return Stone(
        id: data.indexOf(d),
        width: width,
        height: height,
        child: __buildStoneChild(
          background: d["color"],
          text: "${width}x$height",
          surface: (width * height).toDouble(),
        ),
      );
    }).toList();
  }

  Widget __buildStoneChild({Color background, String text, double surface}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(14,0,21, 0.08),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
          colors: [background, Color.alphaBlend(background.withOpacity(0.6), Colors.black)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(),
    );
  }

}



