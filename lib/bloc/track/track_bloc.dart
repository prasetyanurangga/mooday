import 'dart:async';

import 'package:mooday/bloc/track/track_event.dart';
import 'package:mooday/bloc/track/track_state.dart';
import 'package:mooday/models/track_model.dart';
import 'package:mooday/provider/response_data.dart';
import 'package:mooday/repository/mooday_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  MoodayRepository moodayRepository = MoodayRepository();

  TrackBloc() : super(TrackInitial());

  @override
  TrackState get initialState =>TrackInitial();

  @override
  Stream<TrackState> mapEventToState(TrackEvent event) async* {
    if (event is GetTrackByMood) { 
      yield TrackLoading();
      try {
        final ResponseData<dynamic> response = await moodayRepository.getTracks(event.data);
        print(response.data);
        print(event.data);
        if (response.status == Status.ConnectivityError) {
          yield const TrackFailure(error: "");
        }
        if (response.status == Status.Success) {
          yield TrackSuccess(trackModel: response.data as List<TrackModel>);
        } else {
          yield TrackFailure(error: response.message);
        }
      } catch (error) {
        // print(error);
        yield TrackFailure(error: error.toString());
      }
    }
  }
}