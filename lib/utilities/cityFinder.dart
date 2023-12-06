import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> fetchCityFromCoordinates({double? lat, double? lng}) async {
  final url = Uri.https('geocode.maps.co', '/reverse', {
    'lat': lat.toString(),
    'lon': lng.toString(),
  });

  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final cityName = data['address']['city'];
    return cityName.toString();
  } else {
    print('Failed to fetch city. Status code: ${response.statusCode}');
    return null;
  }
}
