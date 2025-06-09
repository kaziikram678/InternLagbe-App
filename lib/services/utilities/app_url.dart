import 'package:InternLagbe/view/user_location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppUrl {
  static const String baseUrl =
      "https://internships-api.p.rapidapi.com/active-jb-7d?location_filter=Bangladesh";
  //"https://active-jb-7d?location_filter=Bangladesh";

  static const Map<String, String> headers = {
    "x-rapidapi-key": "06828cbf3fmshf50b179995da151p1b7fa6jsn725dc2e99597",
    "x-rapidapi-host": "internships-api.p.rapidapi.com",
  };
}

class RoutesUrl {
  static const String baseurl =
      "https://routes.gomaps.pro/directions/v2:computeRoutes";

  static const Map<String, String> headers = {
    "accept": "*/*",
    "accept-language": "en-US,en;q=0.9",
    "content-type": "application/json",
    "origin": "https://developers-dot-devsite-v2-prod.appspot.com",
    "priority": "u=1, i",
    "referer": "https://developers-dot-devsite-v2-prod.appspot.com/",
    "sec-ch-ua":
        '"Chromium";v="128", "Not;A=Brand";v="24", "Google Chrome";v="128"',
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "Windows",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "cross-site",
    "user-agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36",
    "x-client-data": "CJO2yQEIprbJAQipncoBCL/vygEIkqHLAQiFoM0BGI/OzQE=",
    "x-goog-api-key": "AlzaSyDv4L-XuRgIDdHict0OHNxLBIRMX0kXuOc",
    "x-goog-fieldmask": "*",
  };

  static Future<Map<String, dynamic>> buildRequestBody({
    required double jobLatitude,
    required double jobLongitude,
  }) async {
    final userLocation = UserLocation();
    String originAddress = await userLocation.getCurrentAddress();
    String? destinationAddress = await JobLocation().job_location(
      jobLatitude,
      jobLongitude,
    );
    print(originAddress);
    print(destinationAddress);

    return {
      "origin": {
        "vehicleStopover": false,
        "sideOfRoad": false,
        "address": originAddress,
      },
      "destination": {
        "vehicleStopover": false,
        "sideOfRoad": false,
        "address": destinationAddress ?? 'Unknown Destination',
      },
      "travelMode": "transit",
      "routingPreference": "ROUTING_PREFERENCE_UNSPECIFIED",
      "polylineQuality": "high_quality",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false,
        "avoidIndoor": false,
      },
      "transitPreferences": {
        "allowedTravelModes": ["train", "rail"],
        "routingPreference": "fewer_transfers",
      },
    };
  }
}

class JobLocation {
  Future<String?> job_location(double latitude, double longitude) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final place = placemarks[0];
      //final street = place.street ?? '';
      final subLocality = place.subLocality ?? '';
      final locality = place.locality ?? '';
      final postalCode = place.postalCode ?? '';
      final administrativeArea = place.administrativeArea ?? '';
      final country = place.country ?? '';

      return "$subLocality, $locality, $administrativeArea, $postalCode, $country";
    }
    return null;
  }
}
