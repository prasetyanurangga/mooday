import 'package:mooday/models/track_model.dart';
import 'package:mooday/models/audio_feature_model.dart';
import 'package:mooday/provider/response_data.dart';
import 'package:mooday/provider/api_provider.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MoodayRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<ResponseData> getTracks(Map<String, double> data) async{
  	Response response = await _apiProvider.getTracks(data);
  	ResponseTrackModel responseJust = ResponseTrackModel.fromJson(response.data);
  	if (responseJust == null) {
      return ResponseData.connectivityError();
    }

    if (response.statusCode == 200) {
      return ResponseData.success(responseJust.data);
    } else {
      return ResponseData.error("Error");
    }
  }

  Future<ResponseData> getAudioFeatures(Map<String, String> data) async{
    Response response = await _apiProvider.getAudioFeatures(data);
    ResponseAudioFeatureModel responseJust = ResponseAudioFeatureModel.fromJson(response.data);
    if (responseJust == null) {
      return ResponseData.connectivityError();
    }

    if (response.statusCode == 200) {
      return ResponseData.success(responseJust);
    } else {
      return ResponseData.error("Error");
    }
  }


}