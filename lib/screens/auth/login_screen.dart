import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/forgot_password/reset_option_screen.dart';
import 'package:jynx_dj/screens/auth/registration_screen1.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/screens/welcome_screen.dart';
import 'package:jynx_dj/services/auth_service.dart';
import 'package:jynx_dj/widgets/customize_textfield.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loadData = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              //image: DecorationImage(image: AssetImage("images/Getstarted.png")),
              gradient: LinearGradient(
                colors: [
                    Color(0xFF1B5BA1),
                    Color(0xFF011021)
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter
                ),
              
              
                ),
            child: loadData ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6BEAEC),
              ),
            ) 
            : Padding(
              padding:  EdgeInsets.only(left: size.width*0.075,top: size.height*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                    Get.off(const WelcomeScreen());
                  },
                    child: SvgPicture.asset("images/back.svg"),
                    ),
                  SizedBox(
                    height: size.height*0.04,
                  ),
                  Text("Login",
                  style: GoogleFonts.montserrat().copyWith(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  ),
                  SizedBox(
                    height: size.height*0.005,
                  ),
                  Text("Enter your login details",
                  style: GoogleFonts.montserrat().copyWith(
                    fontSize: 16.0,
                    color: const Color(0xFFFFFFFF)
                  ),
                  ),
                  SizedBox(
                    height: size.height*0.12,
                  ),
                  CustomizeTextField(controller: emailController, hintText: "Email Address / Phone Number"),
                  SizedBox(
                    height: size.height*0.03,
                  ),
                  CustomizeTextField(controller: passwordController, hintText: "Password"),
                  GestureDetector(
                    onTap: (){
                      Get.to(const ResetOptionScreen());
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: size.width*0.5,top: size.height*0.01),
                      child: Text("Forgot Password?",
                      style: GoogleFonts.montserrat().copyWith(
                        color: const Color(0xFF00CCFF),
                        decoration: TextDecoration.underline
                      ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.15,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.13),
                    child: CustomizeButton(onpress: (){

                      if (! _validator(size))
                      {
                        return ; 
                      }

                      loginUser(size);



                    },title: "Login",),
                  ),
                  SizedBox(
                    height: size.height*0.12,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.05),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?",
                        style: GoogleFonts.montserrat().copyWith(
                          color: Colors.white
                        ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(const RegistrationScreen1());
                          },
                          child: Text(" Register Now",
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      );
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





bool _validator(Size size) {
    if (emailController.text.trim().isEmpty ||
        emailController.text.trim() == "") {
          error("Please Provie Email / Phone Number", size);
      return false;
    }
    
    // if(EmailValidator.validate(emailController.text.trim()) == false)
    //     {
    //       error("Invalid Email, Provided Email is not Valid", size);
    //       return false;        
    //     }
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.trim() == "") {
          error("Please Enter Your Password", size);
      return false;
    }

    return true;
    }

    void loginUser (Size size) async{
      setState(() {
        loadData = true;
      });
      String result = await AuthServices().loginUser(emailController.text.trim(), passwordController.text.trim());

      setState(() {
        loadData = false;
      });
      if (result != "0")
      {
      //SharedPreference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', result);
      await prefs.setString("login", "true");
      Get.offAll(const EventScreen());
      }
      else {
        error("Error while login, Given does not match with any user", size);
      }
    }

    
    



}