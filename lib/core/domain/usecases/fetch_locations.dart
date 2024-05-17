import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/repository/ilocation_repository.dart';

class FetchLocations {
  FetchLocations({
    required ILocationRepository repository,
  }) : _repository = repository;

  final ILocationRepository _repository;

  Future<Location> call({required String url}) async {
    final location = await _repository.fetchLocations(url: url);
    return location;
  }
}
