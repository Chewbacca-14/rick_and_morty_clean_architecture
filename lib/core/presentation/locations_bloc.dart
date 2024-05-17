import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/usecases/fetch_locations.dart';
import 'package:rick_and_morty_clean_architecture/core/presentation/locations_events.dart';
import 'package:rick_and_morty_clean_architecture/core/presentation/locations_states.dart';

class LocationsBloc extends Bloc<LocationsEvents, LocationsState> {
  final FetchLocations _fetchLocations;

  LocationsBloc({
    required FetchLocations fetchLocations,
  })  : _fetchLocations = fetchLocations,
        super(LocationsLoadingState()) {
    on<FetchLocationsData>((event, emit) async {
      emit(LocationsLoadingState());
      try {
        if (event.url == '') {
          emit(LocationsEmptyState());
        } else {
          Location location = await _fetchLocations.call(url: event.url!);
          emit(
            LocationsSuccessState(
              location: location,
            ),
          );
        }
      } catch (e) {
        emit(
          LocationsErrorState(
            'ERROR: $e',
          ),
        );
      }
    });
  }
}
