
import 'package:flutter/material.dart';
class CustomeIconContainer extends StatefulWidget {
  final VoidCallback onpress;
  IconData icon;

  CustomeIconContainer({
    required this.icon,
    required this.onpress
  });

  @override
  State<CustomeIconContainer> createState() => _CustomeIconContainerState();
}

class _CustomeIconContainerState extends State<CustomeIconContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        width: size.width*0.12,
        height: size.height*0.04,
        decoration: const BoxDecoration(
          color:  Color(0xFF143B66),
          shape: BoxShape.circle
        ),
        child: Center(
          child: Icon(widget.icon,
          color: Colors.white,
          size: 16,),
        ),
      ),
    );
  }
}