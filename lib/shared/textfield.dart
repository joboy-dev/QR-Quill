// ignore_for_file:, must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    this.fillColor,
    this.filled=false,
    this.borderRadius,
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
  final bool? filled;
  final Color? fillColor;
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
  final double? borderRadius;
  // Function(String? newValue) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: TextFormField(
        readOnly: readonly ?? false,
        initialValue: initialValue,
        minLines: 1,
        maxLines: maxLines ?? 1,
        style: kNormalTextStyle(context).copyWith(
          fontSize: fontSize ?? 15.sp, 
          color: textColor ?? kFontTheme(context),
        ),
        cursorColor: cursorColor,
        obscureText: obscureText,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          filled: filled,
          fillColor: fillColor,
          hintStyle: kNormalTextStyle(context).copyWith(
              color: kFontTheme(context).withOpacity(0.5), 
              fontSize: fontSize ?? 15.sp,
              fontWeight: FontWeight.normal,
            ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 25.r, left: 15.r),
            child: Icon(
              prefixIcon,
              color: iconColor,
              size: 20.r,
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
            color: kFontTheme(context).withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorStyle: TextStyle(
            color: errorTextStyleColor,
            fontSize: 15.sp,
          ),
        ),
        // onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty ) {
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
    this.maxLines,
    this.icon,
    this.borderRadius
  });

  final String? initialValue;
  final String? labelText;
  final String hintText;
  final bool? readonly;
  final int? maxLines;
  final Function(String? value) onChanged;
  final String? Function(String? value)? validator;
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
  final IconData? icon;
  final double? borderRadius;
  // Function(String? newValue) onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: TextFormField(
        readOnly: readonly ?? false,
        initialValue: initialValue,
        style: kNormalTextStyle(context).copyWith(
          fontSize: fontSize ?? 15.sp, 
          color: textColor ?? kFontTheme(context),
        ),
        minLines: 1,
        maxLines: maxLines ?? 1,
        cursorColor: cursorColor,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kNormalTextStyle(context).copyWith(
              color: kFontTheme(context).withOpacity(0.5), 
              fontSize: fontSize ?? 15.sp,
              fontWeight: FontWeight.normal,
            ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 25.r, left: 15.r),
            child: Icon(
              icon ?? Icons.link,
              color: iconColor,
              size: 20.r,
            ),
          ),
          labelStyle: TextStyle(
            color: kFontTheme(context).withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
          labelText: labelText ?? hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorStyle: TextStyle(
            color: errorTextStyleColor,
            fontSize: 15.sp,
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
      fieldHeight: 55.h,
      fieldWidth: double.infinity,
      margin: kAppPadding(),
      fieldBorderStyle: FieldBorderStyle.square,
      borderRadius: BorderRadius.circular(45.r),
      fieldBackgroundColor: Colors.transparent,
      activeBackgroundColor: Colors.transparent,
      borderColor: kTertiaryColor,
      activeBorderColor: kSecondaryColor,
      obscureText: true,
      // autofocus: true,
      keyboardType: TextInputType.number,
      textStyle: kYellowNormalTextStyle(context).copyWith(
        fontSize: 50.sp,
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
    this.labelText,
    this.iconSize,
    this.fontSize,
    this.padding,
    required this.onChanged,
    required this.prefixIcon,
    required this.iconColor, 
    required this.enabledBorderColor, 
    required this.focusedBorderColor, 
    required this.errorBorderColor, 
    required this.focusedErrorBorderColor, 
    required this.errorTextStyleColor,
    this.borderRadius,
  });

  final dynamic value;
  final String? labelText;
  final List<DropdownMenuItem> items;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsets? padding;
  final IconData prefixIcon;
  final Color iconColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final void Function(dynamic value)? onChanged;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      items: items,
      style: kYellowNormalTextStyle(context).copyWith(fontSize: fontSize ?? 15.sp),
      onChanged: onChanged,
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4,
      padding: padding ?? const EdgeInsets.only(bottom: 20.0),
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: kNormalTextStyle(context).copyWith(
          color: kFontTheme(context).withOpacity(0.5), 
          fontSize: fontSize ?? 15.sp,
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.r, right: 25.r),
          child: Icon(
            prefixIcon,
            color: iconColor,
            size: iconSize ?? 20.r,
          ),
        ),
        labelText: labelText ?? 'Category',
        labelStyle: TextStyle(
          color: kFontTheme(context).withOpacity(0.5),
          fontWeight: FontWeight.normal,
          fontSize: 15.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
        ),
        errorStyle: TextStyle(
          color: errorTextStyleColor,
          fontSize: 17.sp,
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
    this.labelText,
    required this.onChanged,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.cursorColor,
    this.borderRadius,
  });

  final String? initialValue;
  final String hintText;
  final String? labelText;
  final bool? readonly;
  final Function(String? value) onChanged;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color cursorColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: TextFormField(
        readOnly: readonly ?? false,
        maxLines: null,
        minLines: 4,
        keyboardType: TextInputType.multiline,
        initialValue: initialValue,
        style: kYellowNormalTextStyle(context),
        cursorColor: cursorColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kNormalTextStyle(context).copyWith(color: kFontTheme(context).withOpacity(0.5)),
          // labelText: labelText ?? hintText,
          labelStyle: TextStyle(
            color: kFontTheme(context).withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: errorBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedErrorBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
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
      ),
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
    this.borderRadius,
    this.labelText,
    this.hintText,
    // required this.disableButton,
  });

  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final Color iconColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color cursorColor;
  final double? borderRadius;
  // bool disableButton;

  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: TextFormField(
        readOnly: readOnly ?? false,
        initialValue: initialValue,
        cursorColor: cursorColor,
        keyboardType: TextInputType.emailAddress,
        style: kYellowNormalTextStyle(context).copyWith(fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hintText ?? 'Email',
          hintStyle: kNormalTextStyle(context).copyWith(color: kFontTheme(context).withOpacity(0.5)),
          labelText: labelText ?? 'Email',
          labelStyle: TextStyle(
            color: kFontTheme(context).withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 25.r, left: 15.r),
            child: Icon(
              Icons.email_rounded,
              color: iconColor,
              size: 20.r,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: errorBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedErrorBorderColor ?? Colors.transparent, width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          ),
          errorStyle: TextStyle(
            color: errorTextStyleColor,
            fontSize: 15.sp,
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

class DateField extends StatelessWidget {
   DateField({
    super.key,
    required this.hintText,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.iconColor,
    required this.onSaved,
    required this.onDateChanged,
    this.initialValue,
    this.borderRadius,
    this.selectedDate,
  });

  final String hintText;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color iconColor;
  final String? initialValue;
  final double? borderRadius;
  DateTime? selectedDate;
  final Function(DateTime? date)? onSaved;
  final Function(DateTime date)? onDateChanged;

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: FormField<DateTime>(
        // initialValue: DateTime.parse(initialValue!) ?? DateTime.parse( now.toIso8601String().substring(0, 10)),
        builder: (dateState) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: '',
              hintStyle:
                  kNormalTextStyle(context).copyWith(color: kFontTheme(context).withOpacity(0.5), fontSize: 15.sp),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Icon(
                  FontAwesomeIcons.calendar,
                  color: iconColor,
                  size: 15.sp,
                ),
              ),
              labelStyle: TextStyle(
                color: kFontTheme(context).withOpacity(0.5),
                fontWeight: FontWeight.normal,
                fontSize: 15.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: enabledBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusedErrorBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              errorStyle: TextStyle(
                color: errorTextStyleColor,
              ),
            ),
            child: InkWell(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                // selectedDate = await showDatePicker(
                  context: context,
                  initialDate: dateState.value ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null && pickedDate != dateState.value) {
                  dateState.didChange(pickedDate);
                  if(onDateChanged != null) {
                    onDateChanged!(pickedDate);
                  }
                }
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      dateState.value != null
                          ? dateState.value!.toIso8601String().substring(0, 10).replaceAll('-', '/')
                          : hintText,
                      style: kYellowNormalTextStyle(context).copyWith(fontSize: 13.sp),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 20.sp,
                      color: kFontTheme(context).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a date';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.hintText,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.iconColor,
    required this.onSaved,
    required this.onTimeChanged,
    this.initialValue,
    this.borderRadius
  });

  final String hintText;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color iconColor;
  final String? initialValue;
  final double? borderRadius;
  final Function(TimeOfDay? time)? onSaved;
  final Function(TimeOfDay time)? onTimeChanged;

  @override
  Widget build(BuildContext context) {
    // TimeOfDay now = TimeOfDay.now();
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: FormField<TimeOfDay>(
        // initialValue: TimeOfDay.parse(initialValue!) ?? TimeOfDay.parse( now.toIso8601String().substring(0, 10)),
        builder: (timeState) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: '',
              hintStyle:
                  kNormalTextStyle(context).copyWith(color: kFontTheme(context).withOpacity(0.5), fontSize: 15.sp),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Icon(
                  FontAwesomeIcons.clock,
                  color: iconColor,
                  size: 15.sp,
                ),
              ),
              labelStyle: TextStyle(
                color: kFontTheme(context).withOpacity(0.5),
                fontWeight: FontWeight.normal,
                fontSize: 15.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: enabledBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusedErrorBorderColor, width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
              ),
              errorStyle: TextStyle(
                color: errorTextStyleColor,
              ),
            ),
            child: InkWell(
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: timeState.value ?? TimeOfDay.now(),
                );
                if (pickedTime != null && pickedTime != timeState.value) {
                  timeState.didChange(pickedTime);
                  if(onTimeChanged != null) {
                    onTimeChanged!(pickedTime);
                  }
                  // selectedDate = pickedTime;
                }
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      timeState.value != null
                          ? timeState.value!.format(context)
                          : hintText,
                      style: kYellowNormalTextStyle(context).copyWith(fontSize: 13.sp),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 20.sp,
                      color: kFontTheme(context).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a date';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}

class MediaUploadField extends StatefulWidget {
  MediaUploadField({
    super.key,
    required this.mediaPath,
    required this.pickImage,
    // required this.pickedMedia
    // required this.iconColor,
  });

  String? mediaPath;
  Function() pickImage;

  @override
  State<MediaUploadField> createState() => _MediaUploadFieldState();
}

class _MediaUploadFieldState extends State<MediaUploadField> {
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: 20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload Media (e.g. jpg, png)', 
                  style: kNormalTextStyle(context).copyWith(
                    fontSize: 15.sp,
                    color: kFontTheme(context)
                  ),
                ),
                widget.mediaPath != null ? GestureDetector(
                  onTap: () {
                    setState(() {
                      // widget.pickedMedia = null;
                      widget.mediaPath = null;
                    });
                  },
                  child: Text(
                    'Remove', 
                    style: kYellowNormalTextStyle(context).copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ) : const SizedBox(),
              ],
            ),

            SizedBox(height: 10.h),

            GestureDetector(
              onTap: widget.pickImage,
              child: Container(
                width: double.infinity,
                height: 300.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kFontTheme(context),
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: widget.mediaPath == null ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const UploadFieldIcon(icon: FontAwesomeIcons.image),
                    const SizedBox(height: 20.0),
                    Text(
                      'Click here to upload media (e.g. photos)',
                      style: kNormalTextStyle(context).copyWith(color: kFontTheme(context), fontSize: 15.sp),
                    ),
                  ],
                ) : Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Image.file(
                    File(widget.mediaPath!),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.r),
              child: Text(
                widget.mediaPath == null 
                  ? 'No file selected' 
                  : 'File selected: \n${widget.mediaPath!.split('/').last}',
                style: kNormalTextStyle(context).copyWith(
                  color: widget.mediaPath == null ? kFontTheme(context) : kSecondaryColor,
                  fontSize: 15.r,
                ),
              ),
            ),
          ],
        ),
      );
    }
}


class FileUploadField extends StatefulWidget {
  FileUploadField({
    super.key,
    required this.filePath,
    required this.pickFile
  });

  String? filePath;
  Function() pickFile;

  @override
  State<FileUploadField> createState() => _FileUploadFieldState();
}

class _FileUploadFieldState extends State<FileUploadField> {

  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upload File',
                style: kNormalTextStyle(context).copyWith(
                  fontSize: 15.sp,
                  color: kFontTheme(context)
                ),
              ),
              widget.filePath != null ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.filePath = null;
                  });
                },
                child: Text(
                  'Remove', 
                  style: kYellowNormalTextStyle(context).copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ) : const SizedBox(),
            ],
          ),

          SizedBox(height: 10.h),

          GestureDetector(
            onTap: widget.pickFile,
            child: Container(
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kFontTheme(context),
                  width: 1.w
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.r),
                    child: Wrap(
                      spacing: 20.r,
                      alignment: WrapAlignment.center,
                      children: const [
                        UploadFieldIcon(icon: FontAwesomeIcons.solidFileWord),
                        UploadFieldIcon(icon: FontAwesomeIcons.solidFilePowerpoint),
                        UploadFieldIcon(icon: FontAwesomeIcons.solidFileExcel),
                        UploadFieldIcon(icon: FontAwesomeIcons.solidFilePdf),
                        UploadFieldIcon(icon: FontAwesomeIcons.solidFileZipper),
                        UploadFieldIcon(icon: FontAwesomeIcons.solidFileImage),
                      ]
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: Text(
                      widget.filePath == null ? 'Click here to upload file' :'Selected File:\n${widget.filePath!.split('/').last}',
                      style: kNormalTextStyle(context).copyWith(
                        color: widget.filePath == null ? kFontTheme(context) : kSecondaryColor,
                        fontSize: 15.r
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ) 
            ),
          ),
        ],
      ),
    );
  }
}

class UploadFieldIcon extends StatelessWidget {
  const UploadFieldIcon({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Icon(
        icon,
        size: 40.r,
        color: kSecondaryColor.withOpacity(0.7),
      ),
    );
  }
}

