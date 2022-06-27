// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jynx_dj/screens/auth/forgot_password/reset_password_screen.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/forgot_password/email_phone_screen.dart';
class VerifyOtpScreen extends StatefulWidget {
  bool email;
  String emailPhone;
  String verificationID;
  var auth;
  VerifyOtpScreen({
    required this.email,
    required this.emailPhone,
    required this.verificationID,
    required this.auth,
  });

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  TextEditingController _pinController = TextEditingController();
  late String verificationCode;
  bool verficationSuccessful = false; 
  var _formKey = GlobalKey<FormState>();
  bool loadData = false;
  final _pinPutFocusNode = FocusNode();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendEmailOtp();
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
                    Get.to(EmailPhoneScreen(email: widget.email),);
                  },
                  child: SvgPicture.asset("images/back.svg"),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: size.width*0.025),
                  child: Text(widget.email ? "Verify Email" : "Verify Phone",
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
                  child: Text( widget.email ? "code send to your email" 
                  : "code send to your phone.",
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
                    verifyOtp();
                  }, title: "Enter"),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                Center(
                  child: Text("Resend Code?",
                  style: GoogleFonts.montserrat().copyWith(
                    decoration: TextDecoration.underline,
                    color: Colors.white
                  ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      );
  }

  void sendEmailOtp () async {
    if (widget.email)
    {
      
      var res = await EmailAuth(sessionName: "JYNX DJ").sendOtp(recipientMail: widget.emailPhone);
      if (res) {
        print("otp has been send");
      }

    }
  }

  void verifyOtp () async{
    if (widget.email) {

    }
    else {
      verifyPhoneOtp();
    }
  }

  void verifyPhoneOtp () async{
    setState(() {
      loadData = true;
    });
                             AuthCredential credential = PhoneAuthProvider.credential(
                                  verificationId: widget.verificationID,
                                  smsCode: _pinController.text);
                                  UserCredential result =
                                  await widget.auth.signInWithCredential(credential);
                              User? firebaseUser = result.user;
                              if( firebaseUser !=null)
                              {
                                print("inside firebase User");
                                Get.offAll(ResetPasswordScreen(
                                  emailPhone: "0"+widget.emailPhone,
                                   email: widget.email));
                                   setState(() {
                                     loadData = false;
                                   });
                              }
                              else{
                                Get.snackbar(
                             "Verification Code",
                              "Verification Code that you enter is wrong",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              duration:const  Duration(seconds: 2),
                              );
                              setState(() {
                                loadData = false;
                              });
                              }
  }

}