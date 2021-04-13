import 'package:dio/dio.dart';
import 'dart:async';


class ApiProvider{
  final Dio _dio = Dio();

  Future<Response> getTracks(Map<String, double> data) async {
    String _endpoint = "http://secret-mooday.herokuapp.com/get_audio_feature_track";
    Response response;
    try {
      response = await _dio.post(_endpoint, data: data);
      print(response);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
    return response;
  }
}