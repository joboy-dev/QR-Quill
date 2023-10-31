// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/screens/create/barcode/create_barcode.dart';
import 'package:qr_quill/screens/create/qr_code/create_qrcode.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/textfield.dart';

enum FilterOption {QRCode, Barcode, None}
const optionIcons = {
  FilterOption.QRCode: FontAwesomeIcons.qrcode,
  FilterOption.Barcode: FontAwesomeIcons.barcode,
  FilterOption.None: null,
};

class Create extends StatefulWidget {
  const Create({super.key});

  static const String id = 'create';

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  FilterOption filterOption = FilterOption.None;

  @override
  Widget build(BuildContext context) {
    // logger('Device Height: ${kHeightWidth(context).height}');
    // logger('Device width: ${kHeightWidth(context).width}');

    return Scaffold(
      body: Padding(
        padding: kAppPadding(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Create QR Code',
                      onPressed: () {
                        // navigatorPushNamed(context, CreateQRCode.id);
                        navigatorPush(context, const CreateQRCode());
                      },
                      buttonColor: kSecondaryColor,
                      icon: Icons.qr_code_2_rounded
                    ),
                  ),

                  SizedBox(width: 20.w),

                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Create Bar Code',
                      onPressed: () {
                        navigatorPush(context, const CreateBarcode());
                      },
                      buttonColor: kSecondaryColor,
                      icon: FontAwesomeIcons.barcode,
                    ),
                  )
                ]
              )
            ),

            SizedBox(height: 15.h),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Created QR/Bar Codes',
                    // icon: FontAwesomeIcons.qrcode,
                    titleColor: kSecondaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                  ),
                  SizedBox(height: 5.h),

                  Form(
                    child: Row(
                      children: [
                        const Spacer(),
                        // const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: kHeightWidth(context).width >= 800 ? 1 : 2,
                          child: DropDownFormField(
                            value: filterOption,
                            labelText: 'Filter by:',
                            padding: const EdgeInsets.only(bottom: 0.0),
                            iconSize: 20.r,
                            // fontSize: 10.sp,
                            items: FilterOption.values
                              .map(
                                (option) => DropdownMenuItem(
                                  value: option,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        option.name,
                                        style: kYellowNormalTextStyle(context).copyWith(fontSize: 12.sp),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.r),
                                        child: Icon(
                                          optionIcons[option],
                                          size: 10.r,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ].animate(
                                        interval: kAnimationDurationMs(100),
                                        effects: MyEffects.slideShake()
                                    )
                                  ),
                                ),
                              )
                            .toList(),
                            prefixIcon: FontAwesomeIcons.filter,
                            iconColor: kSecondaryColor,
                            enabledBorderColor: Colors.transparent, 
                            focusedBorderColor: Colors.transparent, 
                            errorBorderColor: Colors.transparent, 
                            focusedErrorBorderColor: Colors.transparent, 
                            errorTextStyleColor: Colors.transparent, 
                            onChanged: (value) {
                              setState(() {
                                filterOption = value;
                              });
                            },
                          ),
                        ),
                        // const Expanded(flex: 1, child: SizedBox()),
                      ],
                    )
                  ),

                  SizedBox(
                    height: kHeightWidth(context).height * 0.5 - 70,
                    child: Padding(
                      padding: kAppPadding().copyWith(top: 0.0),
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return Card(
                            color: kScaffoldBgColor(context),
                            surfaceTintColor: kScaffoldBgColor(context),
                            margin: EdgeInsets.only(bottom: 15.r),
                            shadowColor: kSecondaryColor,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: kFontTheme(context),
                              )
                            ),
                            child: Padding(
                              padding: kAppPadding().copyWith(bottom: 15.r),
                              child: Row(
                                children: [
                                  Icon(Icons.zoom_in, size: 30.r, color: kSecondaryColor),
                                ],
                              ),
                            ),
                          ).animate(
                            delay: kAnimationDurationMs(100),
                            effects: MyEffects.fadeSlide(offset: const Offset(-0.1, 0.0))
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            )
          ].animate(
            delay: kAnimationDurationMs(500),
            interval: kAnimationDurationMs(200),
            effects: MyEffects.fadeSlide(offset: const Offset(0.0, -0.1))
          ),
        ),
      ),
    );
  }
}