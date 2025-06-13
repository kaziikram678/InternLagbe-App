import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedInPage extends StatelessWidget {
  const LinkedInPage({Key? key}) : super(key: key);

  // Function to launch LinkedIn URL
  Future<void> _launchTest() async {
  final Uri url = Uri.parse('https://www.linkedin.com/');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LinkedIn Launcher'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _launchTest,
          icon: const Icon(Icons.open_in_browser),
          label: const Text('Go to LinkedIn'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
    );
  }
}
