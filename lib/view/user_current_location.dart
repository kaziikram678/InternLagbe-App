import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  late GoogleMapController _controller;
  static const CameraPosition cameraPosition = CameraPosition(
    target: LatLng(22.329009785254826, 91.82689845073311),
    zoom: 14,
  );

  List<Marker> markers = [];

  final List<Marker> _list = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(22.329009785254826, 91.82689845073311),
      infoWindow: InfoWindow(title: 'My Current Position'),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.addAll(_list);
    loadData();
  }

  loadData() {
    getUserCurrentLocation().then((value) {
      print("${value.latitude} ${value.longitude}");

      markers.add(
        Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'My home'),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );

      _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((
      error,
      stackTrace,
    ) {
      print(error);
    });

    return Geolocator.getCurrentPosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set.of(markers),
        onMapCreated: _onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
