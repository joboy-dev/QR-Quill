import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/screens/auth/create_pin.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  static const String id = 'get_started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/logo.png'),
                          height: 200.h,
                          width: 200.w,
                        ),
                    
                        SizedBox(height: 20.h),
                    
                        Text(
                          'QR Quill', 
                          style: kYellowNormalTextStyle(context).copyWith(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
  
                        SizedBox(height: 20.h),
                    
                        Text(
                          'A quick and effective way to scan, create, and share QR Codes and Barcodes.', 
                          style: kNormalTextStyle(context).copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ].animate(
                        interval: kAnimationDurationMs(200),
                        effects: MyEffects.fadeSlide(offset: const Offset(0, -0.05)),
                      ),
                    ),
                  ),
                      
                  Button(
                    buttonText: 'Create Pin',
                    onPressed: () {
                      navigatorPushReplacement(context, const CreatePin());
                    }, 
                    buttonColor: kSecondaryColor, 
                    inactive: false,
                  ).animate(
                    delay: kAnimationDurationMs(1000),
                    effects: MyEffects.fadeSlide(offset: const Offset(0, -0.05)),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}