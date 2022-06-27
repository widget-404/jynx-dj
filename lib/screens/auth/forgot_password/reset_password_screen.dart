import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/forgot_password/reset_option_screen.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/services/auth_service.dart';
import 'package:jynx_dj/widgets/customize_textfield.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ResetPasswordScreen extends StatefulWidget {
  String emailPhone;
  bool email;

  ResetPasswordScreen({
    required this.emailPhone,
    required this.email
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswrodController = TextEditingController();
  bool loadData = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold (
        body: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.075,right: size.width*0.05),
          decoration: const BoxDecoration(
            
              gradient: LinearGradient(
                  colors: [
                      Color(0xFF1B5BA1),
                      Color(0xFF011021)
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter),
          ),
          child: loadData ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF6BEAEC),
            ),
          ) 
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Get.offAll(const ResetOptionScreen());
                },
                child: SvgPicture.asset("images/back.svg"),
                ),

              Padding(
                padding: EdgeInsets.only(left: size.width*0.02,
                top: size.height*0.03),
                child: Text("Create Password",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width*0.075
                ),
                ),
              ),

              
              Padding(
                padding: EdgeInsets.only(left: size.width*0.02,
                top: size.height*0.01),
                child: Text("Please reset your password.",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontSize: size.width*0.04
                ),
                ),
              ),
              SizedBox(
                height: size.height*0.1,
              ),
              CustomizeTextField(controller: passwordController, hintText: "Password"),
              SizedBox(
                height: size.height*0.03,
              ),
              CustomizeTextField(controller: repasswrodController, hintText: "Re-Enter Password"),
              SizedBox(
                height: size.height*0.15,
              ),
              Center(
                child: CustomizeButton(onpress: (){
                  updatePassword(size);
                }, title: "Submit"),
              )

            ],
          ),
        ),

      ) 
      );
  }

  updatePassword (Size size) async{
    setState(() {
      loadData = true;
    });
    var result = await AuthServices().updatePassword(widget.emailPhone, passwordController.text.trim());
    if (result != "0") {
      Get.offAll(const EventScreen());
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', result);
      await prefs.setString("login", "true");
      setState(() {
        loadData = false;
      });
    }
    else{
      error("Error Occured while updating password, please try later", size);
      setState(() {
        loadData = false;
      });
    }

  }

  error (String discription, Size size) {
    return AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.ERROR,
      showCloseIcon: true,
      animType: AnimType.BOTTOMSLIDE,
      body: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Text(discription,
            style: GoogleFonts.montserrat().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            ),
          ],
        ),
      )
       
      ).show();
  }

}