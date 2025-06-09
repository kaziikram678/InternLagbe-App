import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class UserLocation {
  double? latitude;
  double? longitude;

  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied");
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getCurrentAddress() async {
    final position = await getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      final place = placemarks[0];
      //final street = place.street ?? '';
      final subLocality = place.subLocality ?? '';
      final locality = place.locality ?? '';
      final postalCode = place.postalCode ?? '';
      final administrativeArea = place.administrativeArea ?? '';
      final country = place.country ?? '';

      return "$subLocality, $locality, $administrativeArea, $postalCode, $country";
    } else {
      throw Exception("Failed to resolve current address");
    }
  }
}
