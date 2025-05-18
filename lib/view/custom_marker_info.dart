import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfo extends StatefulWidget {
  const CustomMarkerInfo({Key? key}) : super(key: key);

  @override
  _CustomMarkerInfoState createState() => _CustomMarkerInfoState();
}

class _CustomMarkerInfoState extends State<CustomMarkerInfo> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final LatLng _latLng = LatLng(22.3333489072997, 91.8253220126988);
  Set<Marker> _markers = {};

  List<String> images = ['assets/images/car.png', 'assets/images/cycling.png'];

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAsset(
        images[i],
        30,
      );

      if (i == 1) {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(22.3333489072997, 91.8253220126988),
            icon: BitmapDescriptor.bytes(markerIcon),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Chittagong_Collegiate_School_Gate.JPG/640px-Chittagong_Collegiate_School_Gate.JPG',
                            ),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: const [
                            Text('Collegiate School Chittagong', style: TextStyle(color: Colors.black)),
                            Spacer(),
                            Text('.5 mi.', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Number one school in Chittagong',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                LatLng(22.3333489072997, 91.8253220126988),
              );
            },
          ),
        );
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(22.334505054570876, 91.8331433341791),
            icon: BitmapDescriptor.bytes(markerIcon),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://propertyguide.com.bd/_next/image?url=https%3A%2F%2Fpropertyguide-store.s3.ap-southeast-1.amazonaws.com%2Fbikroy%2Fmedium_Untitled_design_2024_06_13_T162401_128_fa0b642ee8.jpg&w=3840&q=75',
                            ),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: const [
                            Text('New Market', style: TextStyle(color: Colors.black)),
                            Spacer(),
                            Text('.5 mi.', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'One of the largest market in Chittagong',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                LatLng(22.334505054570876, 91.8331433341791),
              );
            },
          ),
        );
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller) async {
                _customInfoWindowController.googleMapController = controller;
              },
              markers: _markers,
              initialCameraPosition: CameraPosition(target: _latLng, zoom: 14),
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
