import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooday/bloc/track/track_bloc.dart';
import 'package:mooday/bloc/track/track_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultTrackScreen extends StatefulWidget {
  ResultTrackScreen({Key key}) : super(key: key);

  @override
  _ResultTrackScreenState createState() => _ResultTrackScreenState();
}

class _ResultTrackScreenState extends State<ResultTrackScreen> {

  void _launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(24),
        child: BlocBuilder<TrackBloc, TrackState>(
          builder: (context, state){
            if(state is TrackLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            else if(state is TrackSuccess) {
              var data = state.trackModel;
              if(data.length > 0) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
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
                                      width: 64,
                                      height: 64,
                                        imageUrl: data[index].imageCover,
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            width: 36,
                                            height: 36,
                                            child:CircularProgressIndicator()
                                          ),
                                        ),
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
                          );
                        }
                      ),
                   
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      child: Text(
                        "Save As Playlist".toUpperCase(),
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
                      }
                    ),
                  ],
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