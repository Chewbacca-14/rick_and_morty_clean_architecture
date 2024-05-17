import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';

abstract class ILocationApi {
  Future<Location> fetchLocations({required String url});
}
