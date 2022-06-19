
import 'package:flutter/material.dart';
class ImageMoverContainer extends StatefulWidget {
  final VoidCallback onpress;
  IconData icon;

  ImageMoverContainer({
    required this.icon,
    required this.onpress
  });

  @override
  State<ImageMoverContainer> createState() => _ImageMoverContainerState();
}

class _ImageMoverContainerState extends State<ImageMoverContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onpress,
      child: Container(
        width: size.width*0.15,
        height: size.height*0.05,
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