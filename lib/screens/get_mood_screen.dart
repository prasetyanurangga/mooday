import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooday/bloc/mood/mood_bloc.dart';
import 'package:mooday/bloc/mood/mood_event.dart';

class GetMoodScreen extends StatefulWidget {
  GetMoodScreen({Key key}) : super(key: key);

  @override
  _GetMoodScreenState createState() => _GetMoodScreenState();
}

class _GetMoodScreenState extends State<GetMoodScreen> {


  TextEditingController _searchController = TextEditingController();

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
                  width: MediaQuery.of(context).size.width*0.6,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    "what is the mood of this song?",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      filled: true,
                      fillColor:Theme.of(context).backgroundColor,
                      hintText: 'Enter Spotify Url',
                    ),
                  ),
                ),

              ]
            ),
           
            Column(
              children: [
                ElevatedButton(
                  child: Text(
                    "get mood".toUpperCase(),
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
                    BlocProvider.of<MoodBloc>(context).add(
                      GetMoodByTrack(
                        url : _searchController.text
                      ),
                    );
                    Navigator.pushNamed(context, "/result_mood");
                  }
                ),
                TextButton(
                  child: Text(
                    "Want to find track?",
                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 14)
                  ),
                  onPressed: () {
                    Navigator.pop(context);
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
      body: _buildBody()
    );
  }
}