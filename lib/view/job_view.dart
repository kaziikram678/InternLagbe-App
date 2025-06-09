import 'package:InternLagbe/services/states_services.dart';
import 'package:InternLagbe/view/job_description.dart';
import 'package:flutter/material.dart';

class JobView extends StatefulWidget {
  const JobView({super.key});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Recent Intern Jobs",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Cabinet Medium",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Text("Recent Intern Jobs",style: TextStyle(fontSize: 25, fontFamily: "Cabinet Medium", fontWeight: FontWeight.bold),)
            // ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.joblist(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No jobs found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data![index]['organization_logo'],
                                  ),
                                ),
                              ),
                              title: Text(
                                snapshot.data![index]['title'],
                                style: TextStyle(
                                  fontFamily: "Cabinet ExtraBold",
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['organization'],
                                style: TextStyle(fontFamily: "Cabinet Medium"),
                              ),
                              trailing: Text(
                                (snapshot.data![index]['cities_derived']
                                        is List)
                                    ? (snapshot.data![index]['cities_derived']
                                            as List)
                                        .join(', ')
                                    : 'Unknown',
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => JobDescription(
                                          title: snapshot.data![index]['title'],
                                          jobUrl: snapshot.data![index]['url'],
                                          lastDate:
                                              snapshot
                                                  .data![index]['date_validthrough'],
                                          organization_name:
                                              snapshot
                                                  .data![index]['organization'],
                                          organization_desc:
                                              snapshot
                                                  .data![index]['linkedin_org_description'],
                                          organization_url:
                                              snapshot
                                                  .data![index]['organization_url'],
                                          organization_logo:
                                              snapshot
                                                  .data![index]['organization_logo'],
                                          latitude:
                                              (snapshot.data![index]['lats_derived']
                                                          as List)
                                                      .isNotEmpty
                                                  ? snapshot
                                                      .data![index]['lats_derived'][0]
                                                  : 0.0,
                                          longitude:
                                              (snapshot.data![index]['lngs_derived']
                                                          as List)
                                                      .isNotEmpty
                                                  ? snapshot
                                                      .data![index]['lngs_derived'][0]
                                                  : 0.0,
                                        ),
                                  ),
                                );
                              },
                              minTileHeight: 80,
                            ),

                            const Divider(),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
