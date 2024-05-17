import 'package:rick_and_morty_clean_architecture/core/api/ilocation_api.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/repository/ilocation_repository.dart';

class LocationRepositoryImpl implements ILocationRepository {
  final ILocationApi _api;
  LocationRepositoryImpl({
    required ILocationApi api,
  }) : _api = api;

  @override
  Future<Location> fetchLocations({required String url}) async {
    final location = await _api.fetchLocations(url: url);
    return location;
  }
}
