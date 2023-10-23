import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/screens/create/create_barcode.dart';
import 'package:qr_quill/screens/create/create_qrcode.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/navigator.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  static const String id = 'create';

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kAppPadding,
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
                        navigatorPushNamed(context, CreateQRCode.id);
                      },
                      buttonColor: kSecondaryColor,
                      icon: Icons.qr_code_2_rounded
                    ),
                  ),

                  const SizedBox(width: 20.0),

                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Create Bar Code',
                      onPressed: () {
                        navigatorPushNamed(context, CreateBarcode.id);
                      },
                      buttonColor: kSecondaryColor,
                      icon: FontAwesomeIcons.barcode,
                    ),
                  )
                ]
              )
            ),

            const SizedBox(height: 30.0),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Created QR/Bar Codes',
                    icon: FontAwesomeIcons.qrcode,
                    titleColor: kSecondaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                  ),

                  SizedBox(
                    height: kHeightWidth(context).height * 0.52,
                    child: Padding(
                      padding: kAppPadding,
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                            margin: const EdgeInsets.only(bottom: 15.0),
                            shadowColor: kSecondaryColor,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                color: kFontTheme(context),
                              )
                            ),
                            child: Padding(
                              padding: kAppPadding.copyWith(bottom: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.zoom_in, size: 30.0, color: kSecondaryColor),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}