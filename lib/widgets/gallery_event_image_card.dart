import 'package:flutter/material.dart';
class GalleryEventImageCard extends StatefulWidget {
  String imageUrl;
  GalleryEventImageCard({required this.imageUrl});

  @override
  State<GalleryEventImageCard> createState() => _GalleryEventImageCardState();
}

class _GalleryEventImageCardState extends State<GalleryEventImageCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
            height: size.height*0.05,
            width: size.width*0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              //color: Colors.red
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.imageUrl,
              fit: BoxFit.fill,),
            ),
          );
  }
}