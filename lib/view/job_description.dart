import 'dart:io';

import 'package:InternLagbe/services/states_services.dart';
import 'package:InternLagbe/services/utilities/app_url.dart';
import 'package:InternLagbe/view/about_organization.dart';
import 'package:InternLagbe/view/polyline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDescription extends StatefulWidget {
  final String? title;
  final String? jobUrl;
  final String? lastDate;
  final String? organization_name;
  final String? organization_desc;
  final String? organization_url;
  final String? organization_logo;
  final double latitude;
  final double longitude;
  final String? logoUrl;

  const JobDescription({
    super.key,
    required this.title,
    required this.jobUrl,
    required this.lastDate,
    required this.organization_name,
    required this.latitude,
    required this.longitude,
    this.logoUrl,
    required this.organization_desc,
    required this.organization_url,
    required this.organization_logo,
  });

  @override
  State<JobDescription> createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  late GoogleMapController _controller;
  late CameraPosition _cameraPosition;
  final List<Marker> _markers = [];
  String? _distanceText;

  StatesServices statesServices = StatesServices();

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('${widget.jobUrl}');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 14,
    );

    JobLocation().job_location(widget.latitude, widget.longitude);

    _markers.add(
      Marker(
        markerId: const MarkerId('jobLocation'),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: InfoWindow(title: widget.organization_name),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  List<LatLng> decodePolyline(String encoded) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encoded);
    return result
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }

  void _getDirectionsAndNavigate() async {
    final routeData = await statesServices.fetchRoute(
      widget.latitude,
      widget.longitude,
    );
    if (routeData.isEmpty) return;

    final routes = routeData[0]['routes'] as List;
    if (routes.isEmpty) return;

    final firstRoute = routes[0];
    final polylineMap = firstRoute['polyline'] as Map<String, dynamic>;
    final encodedPolyline = polylineMap['encodedPolyline'] ?? '';

    final decodedPoints = decodePolyline(encodedPolyline);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PolylineScreen(decodedPolyline: decodedPoints),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 137, 198, 255),
        title: Center(
          child: Column(
            children: [
              Text(
                'Job Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 450,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: Set.of(_markers),
                compassEnabled: true,
                initialCameraPosition: _cameraPosition,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 137, 198, 255),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.2, 0.9],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              widget.organization_logo!,
                            ),
                            backgroundColor: Colors.grey,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AboutOrganizationDetails(
                                      organization_logo:
                                          widget.organization_logo!,
                                      organization_name:
                                          widget.organization_name!,
                                      organization_desc:
                                          widget.organization_desc!,
                                      organization_url:
                                          widget.organization_url!,
                                    ),
                              ),
                            );
                          },
                        ),

                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: widget.logoUrl != null ? 8 : 0),
                              InkWell(
                                child: Text(
                                  widget.title!,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Cabinet ExtraBold',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Job type: Internship',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Last date of submission: ${widget.lastDate!.substring(0, 10)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (_distanceText != null) ...[
                          SizedBox(height: 5),
                          Text(
                            'Distance: $_distanceText',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            fixedSize: Size(385, 0),
                            side: BorderSide(width: 0.5),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          onPressed: _getDirectionsAndNavigate,
                          child: Text(
                            "Direction",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Cabinet Medium",
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            fixedSize: Size(385, 0),
                            side: BorderSide(width: 0.5),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            textStyle: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            _launchUrl();
                          },
                          child: Text(
                            "Apply Now",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Cabinet Medium",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
