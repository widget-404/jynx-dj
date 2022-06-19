// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class RegistrationStepContainer extends StatefulWidget {
  String title;
  RegistrationStepContainer({
    required this.title
  });

  @override
  State<RegistrationStepContainer> createState() => _RegistrationStepContainerState();
}

class _RegistrationStepContainerState extends State<RegistrationStepContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.45,
      height: size.height*0.05,
      decoration: BoxDecoration(
        color: const Color(0xFF143B66),
        borderRadius: BorderRadius.circular(32)
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: size.width*0.005),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height*0.045,
              width: size.width*0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: widget.title == "screen1" ? const Color(0xFF225F96) : const Color(0xFF143B66)
              ),
              child: Center(
                child: Text("Step 1",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontSize: 12.5
                ),),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: size.width*0.005),
              child: Container(
                height: size.height*0.045,
                width: size.width*0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: widget.title == "screen2" ? const Color(0xFF225F96) : const Color(0xFF143B66)
                ),
                child: Center(
                  child: Text("Step 2",
                  style: GoogleFonts.montserrat().copyWith(
                    color: Colors.white,
                    fontSize: 12.5
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}