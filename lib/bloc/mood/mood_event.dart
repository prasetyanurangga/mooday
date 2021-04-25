import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();
  @override
  List<Object> get props => [];
}

class GetMoodByTrack extends MoodEvent {
	final String url;
  GetMoodByTrack({ 
  		@required this.url
  });
}