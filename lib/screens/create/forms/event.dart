// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class EventForm extends StatefulWidget {
  EventForm({
    super.key,
    required this.eventTitle,
    required this.eventLocation,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  String eventTitle;
  String eventLocation;

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NormalTextField(
          hintText: 'Event Title',
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.eventTitle = value!;
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

        NormalTextField(
          hintText: 'Event Location',
          maxLines: 5,
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.eventLocation = value!;
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
                  widget.startDate = date;
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
                  widget.startTime = time;
                },
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
               child: DateField(
                hintText: 'End Date',
                iconColor: kSecondaryColor,
                enabledBorderColor: kFontTheme(context), 
                focusedBorderColor: kSecondaryColor, 
                errorBorderColor: kRedColor, 
                focusedErrorBorderColor: kRedColor, 
                errorTextStyleColor: kRedColor,
                onSaved: (date) {
                  widget.endDate = date;
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
                  widget.endTime = time;
                },
              ),
            ),
          ],
        ),
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
