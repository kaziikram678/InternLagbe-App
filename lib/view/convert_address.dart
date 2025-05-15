import 'package:flutter/material.dart';
  import 'package:geocoding/geocoding.dart';

class ConvertAddress extends StatefulWidget {
  const ConvertAddress({super.key});

  @override
  State<ConvertAddress> createState() => _ConvertAddressState();
}

class _ConvertAddressState extends State<ConvertAddress> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async{
            List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

            if(placemarks.isNotEmpty){
               Placemark place1= placemarks[0];
              print(place1.country??'no name');
            } else {
              print('NO name');
            }
            List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
            if(placemarks.isNotEmpty){
               Location place2 = locations[0];
              print(place2.latitude??'no latitude');
            } else {
              print('NO name');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                ),
                child: Center(child: Text('Convert')),
              ),
            ),
          ),
        )
      ],
    );
  }
}