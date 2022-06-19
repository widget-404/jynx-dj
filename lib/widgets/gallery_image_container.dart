import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jynx_dj/widgets/drawer.dart';
class GalleryImageContainer extends StatefulWidget {
  const GalleryImageContainer({ Key? key }) : super(key: key);

  @override
  State<GalleryImageContainer> createState() => _GalleryImageContainerState();
}

class _GalleryImageContainerState extends State<GalleryImageContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.35,
      width: size.width,
      child: Stack(
        children: [
          
                  Positioned(
                    top: 0.0,
                    child: Container(
                      height: size.height*0.35,
                      width: size.width,
                      child: Image.asset("images/onboardimage.png",
                      fit: BoxFit.fill,),
                      ),
                  ),
                  Positioned(
                    right: size.width*0.05,
                    top: size.width*0.075,
                    child: SvgPicture.asset(
                      "images/profile.svg",
                      height: size.height * 0.045,
                    ),
                  ),
                  Positioned(
                    left: size.width*0.05,
                    top: size.width*0.075,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(const UserDrawer());
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}