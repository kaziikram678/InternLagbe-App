import 'package:InternLagbe/services/states_services.dart';
import 'package:InternLagbe/view/job_description.dart';
import 'package:flutter/material.dart';

class listTileScreen extends StatefulWidget {
  const listTileScreen({super.key});

  @override
  State<listTileScreen> createState() => _listTileScreenState();
}

class _listTileScreenState extends State<listTileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://media.licdn.com/dms/image/v2/C560BAQHeyCS-seGhPQ/company-logo_200_200/company-logo_200_200/0/1633226686526/vaidtech_logo?e=2147483647&v=beta&t=4Iv0WnZY4NY5gaTDIxsuPJZK-OJAS6jsQjrNvuiwwQU',
                          
                        ),
                        
                      ),
                    ),
                    title: Text("Junior Software engineer",style: TextStyle(fontFamily: "Cabinet ExtraBold"),),
                    subtitle: Text('ABCD Company',style: TextStyle(fontFamily: "Cabinet Medium")),
                    trailing: Text("Dhaka"),
                    minTileHeight: 80,
                  ),
                  Divider(height: 10,),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://media.licdn.com/dms/image/v2/D560BAQHIsBqGHskdjg/company-logo_200_200/company-logo_200_200/0/1730114573321/mybdjobs_logo?e=2147483647&v=beta&t=UJQLEl4VIJDEPSL3Iw8LV12y30EbFJrOPqmQHWpc_Zg',
                      
                        ),
                      ),
                    ),
                    title: Text("Junior Software engineer",style: TextStyle(fontFamily: "Cabinet ExtraBold"),),
                    subtitle: Text('ABCD Company',style: TextStyle(fontFamily: "Cabinet Medium")),
                    trailing: Text("Dhaka"),
                    minTileHeight: 80,
                  ),
                  Divider(height: 10,),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://media.licdn.com/dms/image/v2/C560BAQFEAXyZOLzDRg/company-logo_200_200/company-logo_200_200/0/1630657924394/creatorsacademy_logo?e=2147483647&v=beta&t=ZNsw154cJwfqREHUwu7usfbbttiniSHvUmn7k4WJQXo',
                      
                        ),
                      ),
                    ),
                    title: Text("Junior Software engineer",style: TextStyle(fontFamily: "Cabinet ExtraBold"),),
                    subtitle: Text('ABCD Company',style: TextStyle(fontFamily: "Cabinet Medium")),
                    trailing: Text("Dhaka"),
                    minTileHeight: 80,
                  ),
                  Divider(height: 10,)
                ],

                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
