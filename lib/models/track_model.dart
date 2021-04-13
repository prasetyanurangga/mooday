class ResponseTrackModel {
  List<TrackModel> data;
  bool success;

  ResponseTrackModel({this.data, this.success});

  ResponseTrackModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TrackModel>();
      json['data'].forEach((v) {
        data.add(new TrackModel.fromJson(v));
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

class TrackModel {
  double acousticness;
  String artistId;
  double danceability;
  double energy;
  String id;
  String imageCover;
  double instrumentalness;
  String name;
  String spotifyUrl;
  double valence;
  String artist;

  TrackModel(
      {this.acousticness,
      this.artistId,
      this.danceability,
      this.energy,
      this.id,
      this.imageCover,
      this.instrumentalness,
      this.name,
      this.spotifyUrl,
      this.valence,
      this.artist});

  TrackModel.fromJson(Map<String, dynamic> json) {
    acousticness = json['acousticness'];
    artistId = json['artist_id'];
    danceability = json['danceability'];
    energy = json['energy'];
    id = json['id'];
    imageCover = json['image_cover'];
    instrumentalness = json['instrumentalness'];
    name = json['name'];
    spotifyUrl = json['spotify_url'];
    valence = json['valence'];
    artist = json['artist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acousticness'] = this.acousticness;
    data['artist_id'] = this.artistId;
    data['danceability'] = this.danceability;
    data['energy'] = this.energy;
    data['id'] = this.id;
    data['image_cover'] = this.imageCover;
    data['instrumentalness'] = this.instrumentalness;
    data['name'] = this.name;
    data['spotify_url'] = this.spotifyUrl;
    data['valence'] = this.valence;
    data['artist'] = this.artist;
    return data;
  }
}