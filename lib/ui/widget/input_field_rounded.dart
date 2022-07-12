import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';

class InputFieldRounded extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChange;
  final Widget? suffixIcon;
  final bool secureText;
  final TextInputType keyboardType;
  final String? errortext;
  final FormFieldValidator? validatorCheck;
  const InputFieldRounded(
      {Key? key,
        required this.hint,
        required this.onChange,
        this.validatorCheck,
        this.suffixIcon,
        this.keyboardType = TextInputType.text,
        this.errortext,
        required this.secureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: kRoundedContainer,
      child: TextFormField(
        validator: validatorCheck,
        onChanged: onChange,
        obscureText: secureText,
        cursorColor: ColorPalette.generalPrimaryColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: errortext,
          filled: false,
          hoverColor: ColorPalette.generalPrimaryColor,
          hintText: hint,
          hintStyle: TextStyle(
            color: ColorPalette.generalPrimaryColor
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}