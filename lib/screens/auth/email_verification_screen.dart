// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/phone_verification_screen.dart';
import 'package:jynx_dj/services/auth_service.dart';
import 'package:jynx_dj/widgets/customize_textfield.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';

class EmialVerificationScreen extends StatefulWidget {
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String password;
  String confirmPassword;
  String gender;
  String genre;
  String verificationCode;
  EmialVerificationScreen({
    required this.firstName,
    required this.lastName,
    required this.confirmPassword,
    required this.emailAddress,
    required this.gender,
    required this.genre,
    required this.password,
    required this.phoneNumber,
    required this.verificationCode,
  });

  @override
  State<EmialVerificationScreen> createState() => _EmialVerificationScreenState();
}

class _EmialVerificationScreenState extends State<EmialVerificationScreen> {

  TextEditingController emailController = TextEditingController();
  bool loadData = false;
  bool emailExists = false;
  String code = "";
  
  String verificationCode = "";
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
            padding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.075,right: size.width*0.05),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  
                        Color(0xFF1B5BA1),
                        Color(0xFF011021)
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter
                )
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
                    onTap: () {
                      //Get.to(EmailPhoneScreen(email: widget.email),);
                    },
                    child: SvgPicture.asset("images/back.svg"),
                  ),
                  SizedBox(
                    height: size.height*0.03,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.025),
                    child: Text("Verify Email",
                    style: GoogleFonts.montserrat().copyWith(
                      color: Colors.white,
                      fontSize: size.width*0.1,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.035),
                    child: Text("Please Enter the verification",
                    style: GoogleFonts.montserrat().copyWith(
                      color: Colors.white,
                      fontSize: size.width*0.05
                    ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.035),
                    child: Text("code send to your email address.",
                    style: GoogleFonts.montserrat().copyWith(
                      color: Colors.white,
                      fontSize: size.width*0.05
                    ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.02,right: size.width*0.03),
                    child: CustomizeTextField(
                      controller: emailController,
                      hintText: "Enter Code"),
                  ),
                  SizedBox(
                    height: size.height*0.1,
                  ),
                  Center(
                    child: CustomizeButton(onpress: () {
                      if (widget.verificationCode == emailController.text.trim())
                      {
                        loginUser(widget.phoneNumber, context);
                      }
                      else
                      {

                        error("Code that you enter is not correct ${widget.verificationCode} & ${emailController.text}", size);
                      }
                    }, title: "Enter"),
                  )
              ],
            ),
          ),
        ),
      ),
      );
  }

  Future<void> loginUser(String phone, BuildContext context) async {
     setState(() {
       loadData = true;
     });
    _auth.verifyPhoneNumber(
      
      phoneNumber: "+92"+widget.phoneNumber,
      timeout: const Duration(seconds: 100),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) { 
          //Get.offAll(ResetPasswordScreen(emailPhone: _controller.text.trim(), email: widget.email));
         
        } else {
          print('Else Error!');
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        print('Exception : ${exception.message}');
      },
      //Important and interesting
      //CodeSent is the manual procedure of entering code
      codeSent: (String verificationId, int? resendToken) {
        print("Verification Id of the app");
       // print(forceResendingToken);
       print(verificationId);
       print("Junaid Token");
       print(resendToken);
       
        Get.to(PhoneVerifyScreen(
          emailPhone: widget.phoneNumber,
           verificationID: verificationId,
            auth: _auth,
            firstName: widget.firstName,
            lastName: widget.lastName,
            emailAddress: widget.emailAddress,
            phoneNumber: widget.phoneNumber,
            password: widget.password,
            confirmPassword: widget.confirmPassword,
            gender: widget.gender,
            genre: widget.genre

           )
           );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Verification Id of the app");
        //print(verificationId);
        setState(() {
          verificationCode = verificationId;
          loadData = false;
        });
      },
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


  

}