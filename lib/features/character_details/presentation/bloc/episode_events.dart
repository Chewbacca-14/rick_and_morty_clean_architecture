import 'package:equatable/equatable.dart';

abstract class EpisodeEvents extends Equatable {}

class FetchEpisodeData extends EpisodeEvents {
  final String url;
  FetchEpisodeData({required this.url});

  @override
  List<Object?> get props => [url];
}

class ClearEpisodeList extends EpisodeEvents {
  @override
  List<Object?> get props => [];
}
