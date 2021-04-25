import 'package:mooday/models/audio_feature_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodSuccess extends MoodState {
  final AudioFeatureModel audioFeatureModel;
  final AudioTrackModel audioTrackModel;

  MoodSuccess({@required this.audioFeatureModel, @required this.audioTrackModel});
}
class MoodFailure extends MoodState {
  final String error;

  const MoodFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MoodFailure { error: $error }';
}
