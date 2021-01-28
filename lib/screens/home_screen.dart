import 'package:flutter/material.dart';
import 'package:mooday/constant.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html';
import 'dart:ui';

import 'package:flutter_wall_layout/flutter_wall_layout.dart';


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

  @override
  void initState() {
    super.initState();
    setState((){
        _counter = "initState";
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body:Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              children:[
                Text(
                  "MooDay", textAlign: TextAlign.center
                ),
                SizedBox(height: 20),
                Text(
                  "Save Your Favourite music by mood\nThe music is classified using Spotify's audio feature", textAlign: TextAlign.center
                ),
                SizedBox(height: 20),
                Text(
                  "Your Favourite Tracks", textAlign: TextAlign.center
                ),
                SizedBox(height: 20),
                Row(
                  children:[
                    // RaisedButton(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //     side: BorderSide(color: Colors.white)
                    //   ),
                    //   color: Colors.white,
                    //   onPressed:(){},
                    //   child : Text(
                    //     "last month"
                    //   )
                    // )
                    Container(
                        
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        // When the user taps the button, show a snackbar.
                        onTap: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Tap'),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          child: Text('last month'),
                        ),
                      )
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        // When the user taps the button, show a snackbar.
                        onTap: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Tap'),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          child: Text('last 6 month'),
                        ),
                      )
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        // When the user taps the button, show a snackbar.
                        onTap: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Tap'),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          child: Text('all time'),
                        ),
                      )
                    )
                  ]
                ),
                Row(
                  children:[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(14,0,21, 0.08),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "What's your mood?"
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(14,0,21, 0.08),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children:[
                            Text(
                              "What's your mood?"
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: Colors.grey[500],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children:[
                                
                                Slider(
                                  value: moodValue,
                                  onChanged:(f){
                                    setState((){
                                      moodValue = f;
                                    });
                                  }
                                )
                              ]
                            )
                          ]
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(14,0,21, 0.08),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "What's your mood?"
                        ),
                      ),
                    )
                  ],
                ),
              ]
            )
          )
        )
      )  
      // body: buildWallLayout(),
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



