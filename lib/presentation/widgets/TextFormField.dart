import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
   final TextEditingController controller;
   final TextInputType? keyboardType;
   final Widget? prefixIcon;
   final Widget? suffixIcon;
   final String hintText;
   final String? labelText;
   final String? Function(String?)? validator;
   final Function()? onTap;
   final Color? prefixIconColor;
   final Color? suffixIconColor;
   final bool obscureText;
   final Color? errorColor;
   final AutovalidateMode? autoValidateMode;
   final String? errorText;

   const CustomTextFormField({super.key,
     required this.controller,
     this.keyboardType,
     this.prefixIcon,
     this.suffixIcon,
     required this.hintText,
     this.labelText,
     this.validator,
     this.onTap,
     this.prefixIconColor,
     this.suffixIconColor,
     required this.obscureText, this.errorColor, this.autoValidateMode, this.errorText
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autoValidateMode,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onTap: onTap,

      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,

        suffixIcon: suffixIcon,
        suffixIconColor:suffixIconColor ,
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          color: Color(0xFF091E4A),
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w400,
        ),
        errorText: errorText,
        errorStyle:   TextStyle(
          color: errorColor,
          fontSize: 13.5.sp,
          fontFamily: 'SFProDisplay',
          fontWeight: FontWeight.w400,

        ),
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Color(0xFF091E4A),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF091E4A)),
        ),
      ),
    );
  }


}
