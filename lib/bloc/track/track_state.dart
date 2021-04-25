import 'package:mooday/models/track_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object> get props => [];
}

class TrackInitial extends TrackState {}

class TrackLoading extends TrackState {}

class TrackSuccess extends TrackState {
  final List<TrackModel> trackModel;

  TrackSuccess({@required this.trackModel});
}
class TrackFailure extends TrackState {
  final String error;

  const TrackFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TrackFailure { error: $error }';
}


class TrackTagInitial extends TrackState {}

class TrackTagLoading extends TrackState {}

class TrackTagSuccess extends TrackState {
  final TrackModel trackModel;

  TrackTagSuccess({@required this.trackModel});
}
class TrackTagFailure extends TrackState {
  final String error;

  const TrackTagFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TrackFailure { error: $error }';
}
