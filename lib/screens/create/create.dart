// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/create/barcode/create_barcode.dart';
import 'package:qr_quill/screens/create/barcode/create_barcode_results.dart';
import 'package:qr_quill/screens/create/qr_code/create_qr_results.dart';
import 'package:qr_quill/screens/create/qr_code/create_qrcode.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/services/provider/create_code_provider.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
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
    final createdCodes = context.watch<CreateCodeProvider>().createdCodes;
    final isarDb = IsarDB();

    filterFunction() async {
      if (filterOption == FilterOption.QRCode) {
        await isarDb.getCreatedQRCodes(context);
      } else if (filterOption == FilterOption.Barcode) {
        await isarDb.getCreatedBarcodes(context);
      } else {
        await isarDb.getCreatedCodes(context);
      }
    }

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
                      buttonText: 'Create Barcode',
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
                              filterFunction();
                            },
                          ),
                        ),
                        // const Expanded(flex: 1, child: SizedBox()),
                      ],
                    )
                  ),

                  SizedBox(
                    height: kHeightWidth(context).height * 0.5 - 70,
                    child: createdCodes.isNotEmpty ? Padding(
                      padding: kAppPadding().copyWith(top: 0.0),
                      child: ListView.builder(
                        itemCount: createdCodes.length,
                        itemBuilder: (context, index)  {
                          final code = createdCodes[index];
                          return GestureDetector(
                            onTap: () {
                              navigatorPush(
                                context, 
                                code.type == 'QR Code' ? ShowQRCode(
                                  qrCodeName: code.codeName!, 
                                  selectedCategory: code.category!,
                                  qrData: code.codeData!, 
                                  stringData: code.stringData!,
                                  dateGenerated: code.datetime!,
                              ): ShowBarcode(
                                  barcodeName: code.codeName!, 
                                  selectedCategory: code.category!, 
                                  barcodeData: code.codeData!,
                                  dateScanned: code.datetime!,
                              )
                             );
                            },
                            child: Dismissible(
                              key: ValueKey(code),
                              background: Card(
                                color: kRedColor,
                                margin: EdgeInsets.only(bottom: 15.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        'Swipe to delete', 
                                        style: kNormalTextStyle(context).copyWith(
                                          color: kTertiaryColor,
                                        ),
                                      ),
                                      Icon(Icons.delete, size: 30.r, color: kTertiaryColor,)
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                // delete the code from isar db
                                await isarDb.deleteCreatedCode(context, code.id);
                                showSnackbar(context, 'Code deleted.');
                              },
                              child: Card(
                                color: kScaffoldBgColor(context),
                                surfaceTintColor: kScaffoldBgColor(context),
                                margin: EdgeInsets.only(bottom: 15.r),
                                shadowColor: kSecondaryColor,
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  side: BorderSide(
                                    color: kFontTheme(context),
                                    width: 1.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: kAppPadding().copyWith(bottom: 15.r),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          code.type == 'QR Code' 
                                          ? qrCodeCategoryStringDataIcons[code.category]
                                          : FontAwesomeIcons.barcode, 
                                          size: 25.r, 
                                          color: kSecondaryColor
                                        ),
                                      ),
                            
                                      // CODE DATA
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  code.type!,
                                                  style: kYellowNormalTextStyle(context).copyWith(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                      
                                                Text(
                                                  '- ${code.category!}',
                                                  style: kNormalTextStyle(context).copyWith(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                                      
                                            Text(
                                              code.stringData!.length <= 30 
                                              ? code.stringData!.replaceAll('\n', ' ')
                                              :'${code.stringData!.replaceAll('\n', '- ').substring(0, 30)}...',
                                              style: kNormalTextStyle(context),
                                            ),
                                          ],
                                        )
                                      ),              
                                    ],
                                  ),
                                ),
                              ).animate(
                                delay: kAnimationDurationMs(100),
                                effects: MyEffects.fadeSlide(offset: const Offset(-0.1, 0.0))
                              ),
                            ),
                          );
                        },
                      ),
                    ) : Center(
                      child: Text(
                        'You have no created codes.',
                        style: kNormalTextStyle(context),
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