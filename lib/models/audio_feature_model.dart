class ResponseAudioFeatureModel {
  List<AudioFeatureModel> data;
  bool success;

  ResponseAudioFeatureModel({this.data, this.success});

  ResponseAudioFeatureModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AudioFeatureModel>();
      json['data'].forEach((v) {
        data.add(new AudioFeatureModel.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class AudioFeatureModel {
  double acousticness;
  String analysisUrl;
  double danceability;
  int durationMs;
  double energy;
  String id;
  double instrumentalness;
  int key;
  double liveness;
  double loudness;
  int mode;
  double speechiness;
  double tempo;
  int timeSignature;
  String trackHref;
  String type;
  String uri;
  double valence;

  AudioFeatureModel(
      {this.acousticness,
      this.analysisUrl,
      this.danceability,
      this.durationMs,
      this.energy,
      this.id,
      this.instrumentalness,
      this.key,
      this.liveness,
      this.loudness,
      this.mode,
      this.speechiness,
      this.tempo,
      this.timeSignature,
      this.trackHref,
      this.type,
      this.uri,
      this.valence});

  AudioFeatureModel.fromJson(Map<String, dynamic> json) {
    acousticness = json['acousticness'];
    analysisUrl = json['analysis_url'];
    danceability = json['danceability'];
    durationMs = json['duration_ms'];
    energy = json['energy'];
    id = json['id'];
    instrumentalness = json['instrumentalness'];
    key = json['key'];
    liveness = json['liveness'];
    loudness = json['loudness'];
    mode = json['mode'];
    speechiness = json['speechiness'];
    tempo = json['tempo'];
    timeSignature = json['time_signature'];
    trackHref = json['track_href'];
    type = json['type'];
    uri = json['uri'];
    valence = json['valence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acousticness'] = this.acousticness;
    data['analysis_url'] = this.analysisUrl;
    data['danceability'] = this.danceability;
    data['duration_ms'] = this.durationMs;
    data['energy'] = this.energy;
    data['id'] = this.id;
    data['instrumentalness'] = this.instrumentalness;
    data['key'] = this.key;
    data['liveness'] = this.liveness;
    data['loudness'] = this.loudness;
    data['mode'] = this.mode;
    data['speechiness'] = this.speechiness;
    data['tempo'] = this.tempo;
    data['time_signature'] = this.timeSignature;
    data['track_href'] = this.trackHref;
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['valence'] = this.valence;
    return data;
  }
}
