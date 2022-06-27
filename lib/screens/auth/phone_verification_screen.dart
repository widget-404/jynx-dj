// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, avoid_print


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jynx_dj/controllers/registration_controller.dart';
import 'package:jynx_dj/services/auth_service.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contract/contract_screen.dart';
class PhoneVerifyScreen extends StatefulWidget {
  
  String emailPhone;
  String verificationID;
  var auth;
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String password;
  String confirmPassword;
  String gender;
  String genre;
  PhoneVerifyScreen({
    required this.emailPhone,
    required this.verificationID,
    required this.auth,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.confirmPassword,
    required this.password,
    required this.gender,
    required this.genre
    
  });

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {

  TextEditingController _pinController = TextEditingController();
  //late String verificationCode;
  bool verficationSuccessful = false; 
  var _formKey = GlobalKey<FormState>();
  bool loadData = false;
  RegistationController register = Get.find();
  final _pinPutFocusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    //sendEmailOtp();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.075,right: size.width*0.05),
            width: size.width,
            height: size.height,
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
                  child: Text("Verify Phone",
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
                  child: Text("code send to your phone.",
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
                  padding:  EdgeInsets.only(left: size.width*0.03,right: size.width*0.05),
                  child: Form(
                    key: _formKey,
                    child: Pinput(
                      obscureText: true,
                      length: 6,
                      controller: _pinController,
                      focusNode: _pinPutFocusNode,
                      defaultPinTheme: PinTheme(
                        width: size.width*0.12,
                        height: 50,
                        textStyle: GoogleFonts.montserrat().copyWith(
                          fontSize: 14,
                          color: Colors.black
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
        
                        ),
                        
                      ),
                      onSubmitted: (String pin) async{
        
                      },
                    ),
                    ),
                ),
                SizedBox(
                  height: size.height*0.075,
                ),
                Center(
                  child: CustomizeButton(onpress: (){
                    verifyPhoneOtp(size);
                  }, title: "Enter"),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                // Center(
                //   child: Text("Resend Code?",
                //   style: GoogleFonts.montserrat().copyWith(
                //     decoration: TextDecoration.underline,
                //     color: Colors.white
                //   ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      );
  }

  // void sendEmailOtp () async {
  //   if (widget.email)
  //   {
      
  //     var res = await EmailAuth(sessionName: "JYNX DJ").sendOtp(recipientMail: widget.emailPhone);
  //     if (res) {
  //       print("otp has been send");
  //     }

  //   }
  // }

  // void verifyOtp () async{
  //   if (widget.email) {

  //   }
  //   else {
  //     verifyPhoneOtp();
  //   }
  // }

  void verifyPhoneOtp (Size size) async{
    setState(() {
      loadData = true;
    });
    print("Verification ID in the Verify Phone OTP function ${widget.verificationID}");
                             AuthCredential credential = PhoneAuthProvider.credential(
                                  verificationId: widget.verificationID,
                                  smsCode: _pinController.text );
                                  UserCredential result =
                                  await widget.auth.signInWithCredential(credential);
                              User? firebaseUser = result.user;
                              if( firebaseUser !=null)
                              {
                                registerUser(size);
                                // print("inside firebase User");
                                // Get.offAll(ResetPasswordScreen(
                                //   emailPhone: "0"+widget.emailPhone,
                                //    email: widget.email));
                                   setState(() {
                                     loadData = false;
                                   });
                              }
                              else{
                                error("Verification Code that you enter is wrong", size);
                              setState(() {
                                loadData = false;
                              });
                              }
  }

  
  void registerUser (Size size) async{
    setState(() {
      loadData = true;
    });
    String result = await AuthServices().registerUser(
      widget.firstName,
       widget.lastName,
       widget.phoneNumber,
        widget.emailAddress,
        widget.password,
        widget.confirmPassword,
        widget.gender,
        widget.genre);
         print("Value of the result $result");
         setState(() {
           loadData = false;
         });
      if (result == "0")
      {
        error("Error Occured while registration, please try again", size);
      } 
      else if (result == "-1")
      {
        error("Account against given Email has already exist", size);
      }
      else {
      // SharedPreference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', result);
      await prefs.setString("login", "true");
      Get.offAll(const ContractScreen());
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