import 'dart:async';

import 'package:mooday/bloc/mood/mood_event.dart';
import 'package:mooday/bloc/mood/mood_state.dart';
import 'package:mooday/models/audio_feature_model.dart';
import 'package:mooday/provider/response_data.dart';
import 'package:mooday/repository/mooday_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodayRepository moodayRepository = MoodayRepository();

  MoodBloc() : super(MoodInitial());

  @override
  MoodState get initialState =>MoodInitial();

  @override
  Stream<MoodState> mapEventToState(MoodEvent event) async* {
    if (event is GetMoodByTrack) { 
      yield MoodLoading();
      try {
        final ResponseData<dynamic> response = await moodayRepository.getAudioFeatures({
          "id" : event.url
        });
        var finalResponse = response.data;
        if (response.status == Status.ConnectivityError) {
          yield const MoodFailure(error: "");
        }
        if (response.status == Status.Success) {
          yield MoodSuccess(audioFeatureModel: finalResponse.data as AudioFeatureModel, audioTrackModel: finalResponse.track as AudioTrackModel);
        } else {
          yield MoodFailure(error: response.message);
        }
      } catch (error) {
        // print(error);
        yield MoodFailure(error: error.toString());
      }
    }
  }
}