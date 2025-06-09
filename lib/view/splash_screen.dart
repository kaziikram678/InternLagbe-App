import 'dart:async';
import 'dart:math' as math;

import 'package:InternLagbe/view/job_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(vsync: this);


  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5),
      () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>JobView()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller, 
              child: Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Center(
                    child: Image(image: AssetImage("assets/images/ChakriLink.png")),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                );
              }
            ),
          ],
        )
      ),
    );
  }
}