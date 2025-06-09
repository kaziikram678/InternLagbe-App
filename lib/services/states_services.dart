import 'dart:convert';

import 'package:InternLagbe/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<List<dynamic>> joblist() async {
    var response = await http.get(
      Uri.parse(AppUrl.baseUrl),
      headers: AppUrl.headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchRoute(double jobLat, double jobLng) async {
    final requestBody = await RoutesUrl.buildRequestBody(
      jobLatitude: jobLat,
      jobLongitude: jobLng,
    );

    final response = await http.post(
      Uri.parse(RoutesUrl.baseurl),
      headers: RoutesUrl.headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("Route API response: ${response.body}");
      final json = jsonDecode(response.body);
      return [json];
    } else {
      throw Exception('Failed to load route: ${response.statusCode}');
    }
  }
}
