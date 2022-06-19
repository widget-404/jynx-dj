// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomizeTextField extends StatefulWidget {
  String hintText;
  
  TextEditingController controller;
  CustomizeTextField({
    required this.controller,
    required this.hintText
  });

  @override
  State<CustomizeTextField> createState() => _CustomizeTextFieldState();
}

class _CustomizeTextFieldState extends State<CustomizeTextField> {

  bool hidepassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.85,
      height: size.height*0.075,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.hintText == "Password" || widget.hintText == "Re-Enter Password" ? hidepassword : false,
        style: GoogleFonts.montserrat().copyWith(
          color: const Color(0xFF6D9EC6)
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.hintText == "Password" || widget.hintText == "Re-Enter Password"? 
          GestureDetector(
            onTap: (){
              setState(() {
                hidepassword = !hidepassword;
              });
              
            },
            child: Icon(
            hidepassword ?Icons.visibility : Icons.visibility_off),
            ) : null,
          hintStyle: GoogleFonts.montserrat().copyWith(
            color: const Color(0xFF6D9EC6),
            fontSize: 14.0
          ),
          filled: true,
          fillColor: const Color(0xFF143B66),
          focusedBorder: const OutlineInputBorder(
            borderSide:BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          contentPadding: const  EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
          enabledBorder:const  OutlineInputBorder(
            borderSide:BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),

        ),
      ),
    );
  }
}