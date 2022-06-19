// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jynx_dj/screens/welcome_screen.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Color(0xff43CFFC)
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                child: Container(
                  height: size.height*1,
                  width: size.width,
                  child: Image.asset("images/intro.png",
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.fill,),
                ),
              ),
              Positioned(
                bottom: size.height*0.2,
                left: size.width*0.2,
                child: CustomizeButton(onpress: (){
                  Get.to(const WelcomeScreen());
                },title: "Get Started",)),

        //       Positioned(
        //         top: size.height*0.3,
        //         left: size.width*0.18,
        //         child: SvgPicture.asset("images/jynxlogo.svg",
        //         fit: BoxFit.fill,),
        //           ),
        //       Positioned(
        //         bottom: 0.0,
        //         child: Container(
        //           width: size.width,
        //           height: size.height*0.35,
        //           decoration:  const BoxDecoration(
        //             gradient:  LinearGradient(
        //   colors: [
        //     Color(0xFF1B5BA1),
        //     Color(0xFF011021)
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight
        // ),
        //           ),
        //           child: Center(
        //             child: CustomizeButton(onpress: (){
        //               Get.to(WelcomeScreen());
        //             }, title: "Get Started"),
        //           ),
        //         ),
        //       ),
            ],
          ),
        ),
    
      ),
    );
  }
}