import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';

sealed class LocationsState {}

class LocationsErrorState extends LocationsState {
  final String? errorMessage;
  LocationsErrorState(this.errorMessage);
}

class LocationsEmptyState extends LocationsState {}

class LocationsLoadingState extends LocationsState {}

class LocationsSuccessState extends LocationsState {
  Location location;
  LocationsSuccessState({required this.location});
}
