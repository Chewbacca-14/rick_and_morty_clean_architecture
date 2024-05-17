import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';

abstract class ILocationRepository {
  Future<Location> fetchLocations({required String url});
}
