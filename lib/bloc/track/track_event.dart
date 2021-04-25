import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TrackEvent extends Equatable {
  const TrackEvent();
  @override
  List<Object> get props => [];
}

class GetTrackByMood extends TrackEvent {
	final Map<String, double> data;
  GetTrackByMood({ 
  		@required this.data
  });
}