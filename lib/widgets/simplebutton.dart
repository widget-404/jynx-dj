// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SimpleButton extends StatefulWidget {
  final VoidCallback onpress;
  String title;
  SimpleButton({
    required this.onpress,
    required this.title
  });

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        width: size.width*0.6,
        height: size.height*0.075,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: const Color(0xFF143B66)
          
        ),
        child: Center(
          child: Text(widget.title,
          style: GoogleFonts.montserrat().copyWith(
            fontSize: 18,
            color: Colors.white
          )
          ),
        ),
      ),
    );
  }
}