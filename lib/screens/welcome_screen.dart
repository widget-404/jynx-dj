import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/login_screen.dart';
import 'package:jynx_dj/screens/auth/registration_screen1.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:jynx_dj/widgets/simplebutton.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
       // backgroundColor: const Color(0xFF1B5BA1),
        body: Container(
          decoration: const  BoxDecoration(
            gradient:  LinearGradient(
              //stops: [0.9,0.1],
              colors: [
                Color(0xFF1B5BA1),
                Color(0xFF011021)
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter
            )
          ),
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: size.width*0.27,top: size.height*0.1),
                child: SvgPicture.asset("images/jynxcirclelogo.svg"),
              ),
              SizedBox(
                height: size.height*0.17,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.135),
                child: Text("Create a free account",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  //fontSize: size.height*0.036
                  fontSize: 24.2
                ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: size.height*0.05,left: size.width*0.2,right: size.width*0.2),
                child: CustomizeButton(
                  onpress: (){
                    Get.to(const RegistrationScreen1());
                  },
                   title: "Create Account"),
              ),
              Padding(
                padding:  EdgeInsets.only(top: size.height*0.05,left: size.width*0.2,right: size.width*0.2),
                child: SimpleButton(
                  onpress: (){
                    Get.to(const LoginScreen());
                  },
                   title: "Log In"
                   ),
              ),
            ],
          ),
        ),
      ),
      );
  }
}