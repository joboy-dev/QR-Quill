import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';

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
                      onPressed: () {},
                      buttonColor: kSecondaryColor,
                      icon: Icons.qr_code_2_rounded
                    ),
                  ),

                  const SizedBox(width: 20.0),

                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Create Bar Code',
                      onPressed: () {},
                      buttonColor: kSecondaryColor,
                      icon: FontAwesomeIcons.barcode,
                    ),
                  )
                ]
              )
            ),

            const SizedBox(height: 30.0),

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Created QR/Bar Codes',
                    icon: FontAwesomeIcons.accessibleIcon,
                    titleColor: kSecondaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}