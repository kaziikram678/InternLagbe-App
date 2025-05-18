import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class CustomMarkerNetworkImage extends StatefulWidget {
  const CustomMarkerNetworkImage({Key? key}) : super(key: key);

  @override
  _CustomMarkerNetworkImageState createState() => _CustomMarkerNetworkImageState();
}

class _CustomMarkerNetworkImageState extends State<CustomMarkerNetworkImage> {

  final Completer<GoogleMapController> _controller = Completer();


  List<String> images = [ 'assets/images/bus.png' ,'assets/images/car.png', 'assets/images/cycle-rickshaw.png' , 'assets/images/cycling.png', 'assets/images/delivery-bike.png' , 'assets/images/truck.png' ,];


  final List<Marker> _markers =  <Marker>[];
  final List<LatLng> _latLang =  <LatLng>[
    LatLng(22.3333489072997, 91.8253220126988), LatLng(22.332465663875208, 91.82771990757534) ,LatLng(22.332296953818048, 91.83135161857507),
    LatLng(22.334505054570876, 91.8331433341791), LatLng(22.337273814679392, 91.83085809212902), LatLng(22.336504720154995, 91.8324405954368)];

  static const CameraPosition _cameraPosition =  CameraPosition(
    target: LatLng(22.3333489072997, 91.8253220126988),
    zoom: 15,
  );


  Future<Uint8List>  getBytesFromAssets(String path , int width) async
  {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List() , targetHeight:60 );
    ui.FrameInfo fi = await codec.getNextFrame() ;
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  loadData ()async{

    for(int i = 0 ; i< images.length ; i++ ){
      
      Uint8List? image = await  _loadNetworkImage('https://course.unistudies.net/wp-content/uploads/2023/12/rsz_1rsz_uni_course_poster.jpg.webp') ;

      final ui.Codec markerImageCodec = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight:100,
        targetWidth: 100,
      );
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png,
      );

      final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
      _markers.add(
          Marker(markerId: MarkerId(i.toString()) ,
            position: _latLang[i],
            icon: BitmapDescriptor.bytes(resizedMarkerImageBytes),
            anchor: Offset(.1 , .1),
            //icon: BitmapDescriptor.fromBytes(image!.buffer.asUint8List()),
            infoWindow: InfoWindow(
                title: 'This is title marker: '+i.toString()
            ),
          ));
      setState(() {

      });
    }
  }

  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration(size: Size.fromHeight(10) )).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png ,);
    return byteData?.buffer.asUint8List();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _cameraPosition,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),

      ),
    );
  }

}