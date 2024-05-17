import 'dart:convert';
import 'package:rick_and_morty_clean_architecture/core/api/ilocation_api.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/models/locations.dart';
import 'package:http/http.dart' as http;

class LocationApiImpl implements ILocationApi {
  @override
  Future<Location> fetchLocations({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        Location episode = Location.fromJson(jsonData);
        return episode;
      } else {
        print('Failed to load data');
        return Location();
      }
    } catch (e) {
      print('[Fetch Locations] $e');
      return Location();
    }
  }
}
