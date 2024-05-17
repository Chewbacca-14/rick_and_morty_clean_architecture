import 'package:equatable/equatable.dart';

abstract class LocationsEvents extends Equatable {}

class FetchLocationsData extends LocationsEvents {
  final String? url;
  FetchLocationsData({required this.url});

  @override
  List<Object?> get props => [url];
}
