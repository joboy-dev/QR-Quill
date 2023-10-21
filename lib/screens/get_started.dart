import 'package:flutter/material.dart';
import 'package:qr_quill/screens/auth/create_pin.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  static const String id = 'get_started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: kAnimationDuration1);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Center(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: animation.value,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/images/logo.png'),
                                height: 200,
                                width: 200,
                              ),
                          
                              const SizedBox(height: 20.0),
                          
                              Text(
                                'QR Quill', 
                                style: kNormalTextStyle.copyWith(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
      
                              const SizedBox(height: 20.0),
                          
                              Text(
                                'A quick and effective way to scan and create qr codes and barcodes.', 
                                style: kNormalTextStyle.copyWith(
                                  color: kTertiaryColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                            
                        Button(
                          buttonText: 'Create Pin',
                          onPressed: () {
                            navigatorPushNamed(context, CreatePin.id);
                          }, 
                          buttonColor: kSecondaryColor, 
                          inactive: false,
                        ),
                      ],
                    ),
                  );
                },
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}