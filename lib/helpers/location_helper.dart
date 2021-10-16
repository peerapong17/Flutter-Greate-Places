import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDkoOUhA-f7HPOTW0fXHPNRRKfZrLg4tfI';

class LocationHelper {
  static String? getLocationPreviewImage({
    required double lat,
    required double lng,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
