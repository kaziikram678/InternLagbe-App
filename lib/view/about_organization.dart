import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutOrganizationDetails extends StatefulWidget {
  final String? organization_name;
  final String? organization_desc;
  final String? organization_url;
  final String? organization_logo;

  const AboutOrganizationDetails({
    super.key,
    required this.organization_name,
    required this.organization_desc,
    required this.organization_url,
    required this.organization_logo,
  });

  @override
  State<AboutOrganizationDetails> createState() =>
      _AboutOrganizationDetailsState();
}

class _AboutOrganizationDetailsState extends State<AboutOrganizationDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SpringSimulation _simulation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 50,
    );
    _simulation = SpringSimulation(
      SpringDescription(mass: 0.5, stiffness: 100, damping: 10),
      0,
      40,
      0,
    );
    _controller.animateWith(_simulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
  final Uri url = Uri.parse('${widget.organization_url}');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Organization Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 137, 198, 255),
        centerTitle: true,
      ),
      body: Container(
        height: 1000,
        color: const Color.fromARGB(255, 137, 198, 255),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _controller.value),
                    child: child,
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.organization_logo!),
                  backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(height: 30), 
              Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.organization_name!,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cabinet ExtraBold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.organization_desc ?? "No Description Found",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontFamily: "Cabinet Medium",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(width: 0.5),
                        fixedSize: const Size(double.infinity, 50),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: _launchUrl,
                      child: const Text(
                        "More Details",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 137, 198, 255),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Cabinet Bold",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
