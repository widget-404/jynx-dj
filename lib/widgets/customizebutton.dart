// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomizeButton extends StatefulWidget {
  final VoidCallback onpress;
  String title;
  CustomizeButton({ required this.onpress, required this.title});

  @override
  State<CustomizeButton> createState() => _CustomizeButtonState();
}

class _CustomizeButtonState extends State<CustomizeButton> {
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
          boxShadow:  [
            BoxShadow(
              color: const Color(0xFF143B66).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3)
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Color(0xFF45A1F3),
              Color(0xFF6BEAEC)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
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