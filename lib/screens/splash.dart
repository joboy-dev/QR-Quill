import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/wrapper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  static const String id = 'splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // Initialize animation controller
    controller = AnimationController(vsync: this, duration: kAnimationDuration5);

    // Initialize animation
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigatorPushReplacementNamed(context, Wrapper.id);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ScaleTransition(
            scale: animation,
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 250,
              width: 250,
            ),
          ),
        )
      )
    );
  }
}