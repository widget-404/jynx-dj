// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
class BackContainer extends StatefulWidget {
  final VoidCallback onpress;
  BackContainer({
    required this.onpress
  });

  @override
  State<BackContainer> createState() => _BackContainerState();
}

class _BackContainerState extends State<BackContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        height: size.height*0.1,
        width: size.width*0.1,
        decoration: const BoxDecoration(
          //shape: BoxShape.circle,
          color:  Color(0xFF565656)
        ),
        child: const Center(
          child: Icon(Icons.arrow_back_ios,
          color: Colors.white,
          size: 16,),
        ),
      ),
    );
  }
}