// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/create/create_qr_results.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class EventForm extends StatefulWidget {
  const EventForm({
    super.key,
    required this.qrCodeName,
  });

  final String qrCodeName;


  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> with SingleTickerProviderStateMixin {
  bool isLoading = false;

  bool allDayEvent = false;
  String eventTitle = '';
  String eventLocation = '';
  String eventDescription = '';

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  DateTime? eventStart;
  DateTime? eventEnd;

  final _formKey = GlobalKey<FormState>();

  String stringData = '';

  @override
  Widget build(BuildContext context) {

    String generateICalendarData({
      required String eventName,
      required String eventDescription,
      required String eventLocation,
      required DateTime eventDateStart,
      required DateTime eventDateEnd,
      required TimeOfDay eventTimeStart,
      required TimeOfDay eventTimeEnd,
    }) {
      final DateFormat dateFormat = DateFormat("yyyyMMdd");
      final DateFormat timeFormat = DateFormat("HHmmss");

      const westAfricanTime = Duration(hours: -1);
      // Convert TimeOfDay to DateTime
      DateTime eventStart = DateTime(
        eventDateStart.year,
        eventDateStart.month,
        eventDateStart.day,
        eventTimeStart.hour,
        eventTimeStart.minute,
      ).add(westAfricanTime);

      DateTime eventEnd = allDayEvent ? DateTime(
        eventDateStart.year,
        eventDateStart.month,
        eventDateStart.day,
        eventTimeEnd.hour,
        eventTimeEnd.minute,
      ).add(westAfricanTime) : DateTime(
        eventDateEnd.year,
        eventDateEnd.month,
        eventDateEnd.day,
        eventTimeEnd.hour,
        eventTimeEnd.minute,
      ).add(westAfricanTime);


      // Date validation checks
      if (eventStart.isBefore(DateTime.now())) {
        showSnackbar(context, 'Start date cannot be in the past.');
        return '';
      } else if (eventEnd.isBefore(eventStart)) {
        showSnackbar(context, 'End date cannot be before the start date.');
        return '';
      } else {
        return 'BEGIN:VCALENDAR\n'
          'VERSION:2.0\n'
          'BEGIN:VEVENT\n'
          'SUMMARY:$eventName\n'
          'DESCRIPTION:$eventDescription\n'
          'LOCATION:$eventLocation\n'
          'DTSTART:${dateFormat.format(eventStart)}T${timeFormat.format(eventStart)}Z\n' // West African Time
          'DTEND:${dateFormat.format(eventEnd)}T${timeFormat.format(eventEnd)}Z\n' // West African Time
          'END:VEVENT\n'
          'END:VCALENDAR\n';
      }

  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect all data
      allDayEvent 
        ? stringData = '''
Event Name: $eventTitle
Description:\n$eventDescription\n
Location: $eventLocation
Start Date: ${startDate.toIso8601String().substring(0,10)}
Start Time: ${startTime.format(context)}
End Time: ${endTime.format(context)}
        '''
        : stringData = '''
Event Name: $eventTitle
Description:\n$eventDescription\n
Location: $eventLocation
Start Date: ${startDate.toIso8601String().substring(0,10)}
Start Time: ${startTime.format(context)}
End Date: ${endDate.toIso8601String().substring(0,10)}
End Time: ${endTime.format(context)}
        ''';

      // check if data ia valid
      if (generateICalendarData(
        eventName: eventTitle, 
        eventDescription: eventDescription, 
        eventLocation: eventLocation, 
        eventDateStart: startDate, 
        eventDateEnd: endDate,
        eventTimeStart: startTime, 
        eventTimeEnd: endTime
      ) != '') {
        showSnackbar(context, 'Generating QR Code...');
        setState(() {
          isLoading = true;
        });

        await Future.delayed(kAnimationDuration2);

        navigatorPush(context, ShowQRCode(
          qrData: generateICalendarData(
            eventName: eventTitle, 
            eventDescription: eventDescription, 
            eventLocation: eventLocation, 
            eventDateStart: startDate, 
            eventDateEnd: endDate,
            eventTimeStart: startTime, 
            eventTimeEnd: endTime
          ),
          stringData: stringData,
          qrCodeName: widget.qrCodeName,
          selectedCategory: Category.Event,
          )
        );
      }
    } else {
      showSnackbar(context, 'Field validation failed. Ensure all fields are valid.');
    }
  }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          NormalTextField(
            hintText: 'Event Title',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                eventTitle = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: Icons.event,
          ),

          TextareaTextField(
            hintText: 'Event Description',
            onChanged: (value) {
              setState(() {
                eventDescription = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            cursorColor: kSecondaryColor, 
          ),
    
          NormalTextField(
            hintText: 'Event Location',
            maxLines: 5,
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                eventLocation = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor,
            prefixIcon: Icons.place_rounded,
          ),
    
          GestureDetector(
            onTap: () {
              setState(() {
                allDayEvent = !allDayEvent;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Transform.scale(
                    scale: 1.r,
                    child: Checkbox(
                      value: allDayEvent, 
                      fillColor: MaterialStatePropertyAll(allDayEvent ? kSecondaryColor: Colors.transparent),
                      side: BorderSide(
                        width: 1.w,
                        color: kFontTheme(context)
                      ),
                      onChanged: (value) {
                        setState(() {
                          allDayEvent = !allDayEvent;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text('All day event', style: kNormalTextStyle(context))
                ),
              ],
            ),
          ),
    
          Row(
            children: [
              Expanded(
                 child: DateField(
                  hintText: 'Start Date',
                  iconColor: kSecondaryColor,
                  enabledBorderColor: kFontTheme(context), 
                  focusedBorderColor: kSecondaryColor, 
                  errorBorderColor: kRedColor, 
                  focusedErrorBorderColor: kRedColor, 
                  errorTextStyleColor: kRedColor,
                  onSaved: (date) {
                    setState(() {
                      startDate = date!;
                    });
                    logger(startDate);
                  },
                  onDateChanged: (date) {
                    setState(() {
                      startDate = date;
                    });
                    logger(startDate);
                  },
                ),
              ),
    
              const SizedBox(width: 10.0),
    
              Expanded(
                 child: TimeField(
                  hintText: 'Start Time',
                  iconColor: kSecondaryColor,
                  enabledBorderColor: kFontTheme(context), 
                  focusedBorderColor: kSecondaryColor, 
                  errorBorderColor: kRedColor, 
                  focusedErrorBorderColor: kRedColor, 
                  errorTextStyleColor: kRedColor,
                  onSaved: (time) {
                    setState(() {
                      startTime = time!;
                    });
                    logger(startTime);
                  },
                  onTimeChanged: (time) {
                    setState(() {
                      startTime = time;
                    });
                    logger(startTime);
                  },
                ),
              ),
            ],
          ),
    
          Row(
            children: [
              allDayEvent ? const Expanded(child: SizedBox()) : Expanded(
                 child: DateField(
                  hintText: 'End Date',
                  iconColor: kSecondaryColor,
                  enabledBorderColor: kFontTheme(context), 
                  focusedBorderColor: kSecondaryColor, 
                  errorBorderColor: kRedColor, 
                  focusedErrorBorderColor: kRedColor, 
                  errorTextStyleColor: kRedColor,
                  onSaved: (date) {
                    setState(() {
                      endDate = date!;
                    });
                  },
                  onDateChanged: (date) {
                    setState(() {
                      endDate = date;
                    });
                    logger(endDate);
                  },
                ),
              ),
            
              const SizedBox(width: 10.0),
            
              Expanded(
                 child: TimeField(
                  hintText: 'End Time',
                  iconColor: kSecondaryColor,
                  enabledBorderColor: kFontTheme(context), 
                  focusedBorderColor: kSecondaryColor, 
                  errorBorderColor: kRedColor, 
                  focusedErrorBorderColor: kRedColor, 
                  errorTextStyleColor: kRedColor,
                  onSaved: (time) {
                    setState(() {
                      endTime = time!;
                    });
                  },
                  onTimeChanged: (time) {
                    setState(() {
                      endTime = time;
                    });
                    logger(endTime);
                  },
                ),
              ),
            ],
          ),
    
          Button(
              buttonColor: kSecondaryColor,
              buttonText: 'Generate QR Code',
              onPressed: () {
                validateForm();
              },
              inactive: false,
            ),
            SizedBox(height:10.h),
        ].animate(
          interval: kAnimationDurationMs(100),
          effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
        ),
      ),
    );
  }
}
