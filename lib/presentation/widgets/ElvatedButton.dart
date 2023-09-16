import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
   final void Function()? onPressed;
   final double? width;
   final String text;

   const CustomElevatedButton( this.onPressed, this.text, {super.key, this.width=double.infinity});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5A55CA),
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // <-- Radius
          ),
        ),
          child:Text(text,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w500,
          )
          ),

      ),
    );
  }
}
