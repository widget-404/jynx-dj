import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/login_screen.dart';
import 'package:jynx_dj/screens/auth/registration_screen2.dart';
import 'package:jynx_dj/screens/welcome_screen.dart';
import 'package:jynx_dj/widgets/customize_textfield.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:jynx_dj/widgets/registration_step_container.dart';
class RegistrationScreen1 extends StatefulWidget {
  const RegistrationScreen1({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen1> createState() => _RegistrationScreen1State();
}

class _RegistrationScreen1State extends State<RegistrationScreen1> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
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
              gradient: LinearGradient(
                colors: [
                    Color(0xFF1B5BA1),
                    Color(0xFF011021)
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter
                ),
            ),
            child: Padding(
              padding:  EdgeInsets.only(left: size.width*0.075,top: size.height*0.015),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                    Get.off(const WelcomeScreen());
                  },
                      child: SvgPicture.asset("images/back.svg")),
                      SizedBox(
                        height: size.height*0.03,
                      ),
                      Text("Register",
                      style: GoogleFonts.montserrat().copyWith(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      ),
                      SizedBox(
                        height: size.height*0.005,
                      ),
                      Text("Enter the required details",
                      style: GoogleFonts.montserrat().copyWith(
                        fontSize: 16.0,
                        color: const Color(0xFFFFFFFF)
                      ),
                      ),
                      SizedBox(
                        height: size.height*0.035,
                      ),
                      RegistrationStepContainer(title: "screen1"),
                      SizedBox(
                        height: size.height*0.03,
                      ),
                      CustomizeTextField(controller: firstNameController, hintText: "First Name"),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      CustomizeTextField(controller: lastNameController, hintText: "Last Name"),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      CustomizeTextField(controller: phoneController, hintText: "3157553001"),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      CustomizeTextField(controller: emailController, hintText: "Email Address"),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      CustomizeTextField(controller: passwordController, hintText: "Password"),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      CustomizeTextField(controller: repasswordController, hintText: "Re-Enter Password"),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: size.width*0.13),
                        child: CustomizeButton(onpress: (){

                          if ( !_validator(size))
                          {
                            return ; 
                          }

                          Get.to(RegistrationScreen2(
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            emailAddress: emailController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            password: passwordController.text.trim(),
                            confirmPassword: repasswordController.text.trim(),
                          ));
                        }, title: "Submit"),
                      ),
                      SizedBox(
                        height: size.height*0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.08),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Already have an account?",
                            style: GoogleFonts.montserrat().copyWith(
                              color: Colors.white,
                              fontSize: 14
                            ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(const LoginScreen());
                              },
                              child: Text("  Log in now",
                              style: GoogleFonts.montserrat().copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.05,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      );
  }

  bool _validator(Size size) {
    if (firstNameController.text.trim().isEmpty ||
        firstNameController.text.trim() == "") {
          error("Please Enter Your First Name", size);
      return false;
    }
    if (lastNameController.text.trim().isEmpty ||
        lastNameController.text.trim() == "") {
          error("Please Enter Your Last Name", size);
      return false;
    }

    if (phoneController.text.trim().isEmpty ||
        phoneController.text.trim() == "") {
          error("Please Enter Your Phone Number", size);
      return false;
    }

    if (emailController.text.trim().isEmpty ||
        emailController.text.trim() == "") {
          error("Please Enter Your Email Address", size);
      return false;
    }

    if(EmailValidator.validate(emailController.text.trim()) == false)
        {
          error("Invalid Email, Provided Email is not Valid", size);
          return false;        
        }

    
    if (passwordController.text.trim().isEmpty ||
        emailController.text.trim() == "") {
      error("Please Enter Password, it cannot be empty", size);
      return false;
    }

    
    if (repasswordController.text.trim().isEmpty ||
        repasswordController.text.trim() == "") {
        error("Please Enter Confirm Password, it cannot be empty", size);  
      return false;
    }

    if (passwordController.text.trim() != repasswordController.text.trim())
    {
      error("Password and Re Enter Password are not matched", size);
      return false;
    }

    return true;
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