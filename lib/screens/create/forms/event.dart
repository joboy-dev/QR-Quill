import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class EventForm extends StatefulWidget {
  const EventForm({
    super.key, 
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;

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
              // title = value!;
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
              // title = value!;
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
               child: DatePickerField(
                iconColor: kSecondaryColor,
                labelText: 'Start',
                selectedDate: widget.startDate,
              ),
            ),

            const SizedBox(width: 10.0),

            Expanded(
               child: TimePickerField(
                iconColor: kSecondaryColor,
                labelText: 'Time',
                selectedTime: widget.startTime,
              ),
            ),
          ],
        ),

        Row(
          children: [
             Expanded(
               child: DatePickerField(
                iconColor: kSecondaryColor,
                labelText: 'End',
                selectedDate: widget.endDate,
              ),
            ),

            const SizedBox(width: 10.0),

            Expanded(
               child: TimePickerField(
                iconColor: kSecondaryColor,
                labelText: 'Time',
                selectedTime: widget.endTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
