import 'package:InternLagbe/view/about_organization.dart';
import 'package:InternLagbe/view/job_description.dart';
import 'package:InternLagbe/view/splash_screen.dart';
import 'package:InternLagbe/view/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context)=> ThemeProvider())],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<ThemeProvider>().getThemeValue() ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             //Navigator.push(context, MaterialPageRoute(builder: (_) =>JobDescription(title: "ABC COMAPANY", jobUrl: "ADKHDJDJKADSDH", lastDate: "20-20-1023", organization_name: "ABDSHDISDJKDH", latitude: 20.0001110, longitude: 30.000303)));
//             //Navigator.push(context, MaterialPageRoute(builder: (_) => AboutOrganizationDetails(organization_name: "ABC Company", organization_desc: "lorem10",organization_url: "https://www.linkedin.com/company/mybdjobs", organization_logo: "https://media.licdn.com/dms/image/v2/D560BAQHIsBqGHskdjg/company-logo_200_200/company-logo_200_200/0/1730114573321/mybdjobs_logo?e=2147483647&v=beta&t=UJQLEl4VIJDEPSL3Iw8LV12y30EbFJrOPqmQHWpc_Zg")));
//             Navigator.push(context, MaterialPageRoute(builder: (_) => SplashScreen()));

//           },
//           child: Container(
//             padding: EdgeInsets.all(20),
//             color: Colors.blue,
//             child: Text('Go to Second Page', style: TextStyle(color: Colors.white)),
//           ),
//         ),
//       ),
//     );
//   }
// }
