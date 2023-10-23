// ignore_for_file: avoid_print, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:qr_quill/shared/constants.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.iconColor,
    required this.cursorColor,
    required this.prefixIcon,
    this.suffixIcon,
    this.readonly,
    this.fontSize,
    this.textInputType,
    this.textColor,
    this.suffixIconOTap,
    this.labelText,
    this.maxLines,
  });

  final String? initialValue;
  final String? labelText;
  final String hintText;
  final bool? readonly;
  final Function(String? value) onChanged;
  final Function()? suffixIconOTap;
  final Color enabledBorderColor;
  final bool obscureText;
  final Color? textColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color iconColor;
  final Color cursorColor;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final double? fontSize;
  final TextInputType? textInputType;
  final int? maxLines;
  // Function(String? newValue) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        readOnly: readonly ?? false,
        initialValue: initialValue,
        minLines: 1,
        maxLines: maxLines ?? 1,
        style: kNormalTextStyle.copyWith(
          fontSize: fontSize ?? 17.0, 
          color: textColor ?? kFontTheme(context),
        ),
        cursorColor: cursorColor,
        obscureText: obscureText,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kNormalTextStyle.copyWith(
              color: kFontTheme(context).withOpacity(0.5), 
              fontSize: fontSize ?? 17.0,
              fontWeight: FontWeight.normal,
            ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 15.0),
            child: Icon(
              prefixIcon,
              color: iconColor,
              size: 30.0,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: suffixIconOTap ?? () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(suffixIcon, color: kSecondaryColor),
            ),
          ),
          labelText: labelText ?? hintText,
          labelStyle: TextStyle(
            color: kFontTheme(context),
            fontWeight: FontWeight.normal,
            fontSize: 17.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorStyle: TextStyle(
            color: errorTextStyleColor,
            fontSize: 17.0,
          ),
        ),
        // onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field cannot be empty';
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class URLTextField extends StatelessWidget {
  const URLTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
    this.validator,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.iconColor,
    required this.cursorColor,
    this.readonly,
    this.fontSize,
    this.textInputType,
    this.textColor,
    this.suffixIconOTap,
    this.labelText,
    this.maxLines
  });

  final String? initialValue;
  final String? labelText;
  final String hintText;
  final bool? readonly;
  final int? maxLines;
  final Function(String? value) onChanged;
  final String Function(String? value)? validator;
  final Function()? suffixIconOTap;
  final Color enabledBorderColor;
  final Color? textColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color iconColor;
  final Color cursorColor;
  final double? fontSize;
  final TextInputType? textInputType;
  // Function(String? newValue) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        readOnly: readonly ?? false,
        initialValue: 'https://',
        style: kNormalTextStyle.copyWith(
          fontSize: fontSize ?? 17.0, 
          color: textColor ?? kFontTheme(context),
        ),
        minLines: 1,
        maxLines: maxLines ?? 1,
        cursorColor: cursorColor,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kNormalTextStyle.copyWith(
              color: kFontTheme(context).withOpacity(0.5), 
              fontSize: fontSize ?? 17.0,
              fontWeight: FontWeight.normal,
            ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 15.0),
            child: Icon(
              Icons.link,
              color: iconColor,
              size: 30.0,
            ),
          ),
          labelStyle: TextStyle(
            color: kFontTheme(context),
            fontWeight: FontWeight.normal,
            fontSize: 17.0,
          ),
          labelText: labelText ?? hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorStyle: TextStyle(
            color: errorTextStyleColor,
            fontSize: 17.0,
          ),
        ),
        // onSaved: onSaved,
        onChanged: onChanged,
        validator: validator ?? (value) {
          return RegExp(
              r"^(https?|ftp)://[^\s/$.?#].[^\s]*$",
              caseSensitive: false,
          ).hasMatch(value!) ? null : 'Enter a valid URL';
        },
      ),
    );
  }
}

class PinField extends StatelessWidget {
  const PinField({
    super.key,
    required this.onChange,
    required this.oncomplete,
  });

  final Function(String value) onChange;
  final Function(String pincode) oncomplete;

  @override
  Widget build(BuildContext context) {
    return PinCodeFields(
      length: 4,
      fieldHeight: 65.0,
      margin: kAppPadding,
      fieldBorderStyle: FieldBorderStyle.square,
      borderRadius: BorderRadius.circular(25.0),
      fieldBackgroundColor: Colors.transparent,
      activeBackgroundColor: Colors.transparent,
      borderColor: kTertiaryColor,
      activeBorderColor: kSecondaryColor,
      obscureText: true,
      // autofocus: true,
      keyboardType: TextInputType.number,
      textStyle: kNormalTextStyle.copyWith(
        fontSize: 52.0,
        fontWeight: FontWeight.bold,
      ),
      onComplete: oncomplete,
      onChange: onChange
    );
  }
}

class DropDownFormField extends StatelessWidget {

  const DropDownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.prefixIcon,
    required this.iconColor, 
    required this.enabledBorderColor, 
    required this.focusedBorderColor, 
    required this.errorBorderColor, 
    required this.focusedErrorBorderColor, 
    required this.errorTextStyleColor,
  });

  final dynamic value;
  final List<DropdownMenuItem> items;
  final IconData prefixIcon;
  final Color iconColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final void Function(dynamic value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      items: items,
      style: kNormalTextStyle,
      onChanged: onChanged,
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4,
      padding: const EdgeInsets.only(bottom: 20.0),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 25.0),
          child: Icon(
            prefixIcon,
            color: iconColor,
            size: 30.0,
          ),
        ),
        labelText: 'Category',
        labelStyle: TextStyle(
          color: kFontTheme(context).withOpacity(0.5),
          fontWeight: FontWeight.normal,
          fontSize: 17.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorStyle: TextStyle(
          color: errorTextStyleColor,
          fontSize: 17.0,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return 'Make a choice';
        } else {
          return null;
        }
      },
    );
  }
}

class TextareaTextField extends StatelessWidget {
  const TextareaTextField({
    super.key,
    this.initialValue,
    this.readonly,
    required this.hintText,
    required this.onChanged,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.cursorColor,
  });

  final String? initialValue;
  final String hintText;
  final bool? readonly;
  final Function(String? value) onChanged;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color cursorColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      initialValue: initialValue,
      style: kNormalTextStyle,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: kNormalTextStyle.copyWith(color: kFontTheme(context).withOpacity(0.5)),
        labelText: 'Text',
        labelStyle: TextStyle(
          color: kFontTheme(context),
          fontWeight: FontWeight.normal,
          fontSize: 17.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: enabledBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: focusedBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: errorBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: focusedErrorBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorStyle: TextStyle(
          color: errorTextStyleColor,
          fontSize: 15.0,
        ),
      ),
      // onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty || value.length < 10) {
          return 'This field must not be less than 10 characters';
        } else {
          return null;
        }
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key, 
    this.initialValue,
    this.readOnly,
    required this.onChanged,
    required this.iconColor, 
    this.enabledBorderColor, 
    this.focusedBorderColor, 
    this.errorBorderColor, 
    this.focusedErrorBorderColor, 
    required this.errorTextStyleColor, 
    required this.cursorColor,
    // required this.disableButton,
  });

  final String? initialValue;
  final bool? readOnly;
  final Color iconColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color cursorColor;
  // bool disableButton;

  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        readOnly: readOnly ?? false,
        initialValue: initialValue,
        cursorColor: cursorColor,
        keyboardType: TextInputType.emailAddress,
        style: kNormalTextStyle.copyWith(fontSize: 17.0),
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: kNormalTextStyle.copyWith(color: kFontTheme(context).withOpacity(0.5)),
          labelStyle: TextStyle(
            color: kFontTheme(context),
            fontWeight: FontWeight.normal,
            fontSize: 17.0,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 15.0),
            child: Icon(
              Icons.email_rounded,
              color: iconColor,
              size: 30.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.transparent, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.transparent, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: errorBorderColor ?? Colors.transparent, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedErrorBorderColor ?? Colors.transparent, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          errorStyle: TextStyle(
            color: errorTextStyleColor,
            fontSize: 17.0,
          ),
        ),
        onChanged: onChanged,
        validator: (value) {
          return RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!)
              ? null
              : 'Please enter a valid email';
        },
      ),
    );
  }
}

class DatePickerField extends StatefulWidget {
  DatePickerField({
    super.key,
    this.selectedDate,
    this.labelText,
    required this.iconColor,
  });

  String? selectedDate;
  String? labelText;
  Color iconColor;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final formatter = DateFormat.yMd();

  displayDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1, now.month, now.day);
    final lastDate = DateTime(now.year+10, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: lastDate,
   );

   setState(() {
     widget.selectedDate = formatter.format(pickedDate!);
   });

   print('Picked Time: $pickedDate');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: displayDatePicker,
        child: Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: kFontTheme(context))
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.calendar_month,
                    size: 30.0,
                    color: widget.iconColor,
                  ),
                ),
                widget.selectedDate == null ? Text(
                  widget.labelText ?? 'Date',
                  style: kNormalTextStyle.copyWith(color: kFontTheme(context).withOpacity(0.5)),
                ): Text(
                  widget.selectedDate!,
                  style: kNormalTextStyle.copyWith(fontSize: 15.0),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down, 
                  color: kFontTheme(context).withOpacity(0.5),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}

class TimePickerField extends StatefulWidget {
  TimePickerField({
    super.key,
    this.selectedTime,
    this.labelText,
    required this.iconColor,
  });

  String? selectedTime;
  String? labelText;
  Color iconColor;

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {

  displayTimePicker() async {
   final timeNow = TimeOfDay.now();

   final pickedTime = await showTimePicker(
    context: context, 
    initialTime: timeNow,
  );

   setState(() {
     widget.selectedTime = pickedTime?.format(context);
   });

   print('Picked Time: ${pickedTime?.format(context)}');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: displayTimePicker,
        child: Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: kFontTheme(context))
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    FontAwesomeIcons.clock,
                    size: 30.0,
                    color: widget.iconColor,
                  ),
                ),
                widget.selectedTime == null ? Text(
                  widget.labelText ?? 'Date',
                  style: kNormalTextStyle.copyWith(color: kFontTheme(context).withOpacity(0.5)),
                ): Text(
                  widget.selectedTime!,
                  style: kNormalTextStyle.copyWith(fontSize: 15.0),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down, 
                  color: kFontTheme(context).withOpacity(0.5),
                ),
              ],
            ),
          ),
    
        )
      ),
    );
  }
}