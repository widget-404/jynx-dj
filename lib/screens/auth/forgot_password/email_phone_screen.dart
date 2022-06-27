import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/forgot_password/reset_option_screen.dart';
import 'package:jynx_dj/screens/auth/forgot_password/reset_password_screen.dart';
import 'package:jynx_dj/screens/auth/forgot_password/verify_otp_screen.dart';
import 'package:jynx_dj/widgets/customize_textfield.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
class EmailPhoneScreen extends StatefulWidget {
  bool email;
  EmailPhoneScreen({
    required this.email
  });

  @override
  State<EmailPhoneScreen> createState() => _EmailPhoneScreenState();
}

class _EmailPhoneScreenState extends State<EmailPhoneScreen> {

  TextEditingController _controller = TextEditingController();
  bool loadData = false;
  late String verificationCode;
  
final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          
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
          child: loadData ? const Center (
            child: CircularProgressIndicator(
              color: Color(0xFF6BEAEC)
            ),
          ) 
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Get.off(const ResetOptionScreen());
                },
                child: SvgPicture.asset("images/back.svg"),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: size.width*0.005),
                  child: Text(widget.email ? "Enter Email" : "Enter Phone Number",
                  style: GoogleFonts.montserrat().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.05
                  ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.005
                ),
                Padding(
                  padding:  EdgeInsets.only(left: size.width*0.005),
                  child: Text(widget.email ? "Provide Email for the OTP Verification " 
                  : "Provide Phone Number for the OTP Verification",
                  style: GoogleFonts.montserrat().copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    fontSize: size.width*0.035
                  ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                CustomizeTextField(
                  controller: _controller,
                   hintText: widget.email ? "example@gmail.com" :
                    "3157553001"),
                SizedBox(
                  height: size.height*0.05,
                ),
                Center(
                  child: CustomizeButton(onpress: (){
                    
                    if(_controller.text.trim() == "")
                    {
                      error("Please Enter Phone Number", size);
                    }
                    else{
                      setState(() {
                      loadData = true;
                    });
                    loginUser(_controller.text.trim(), context);
                    }
                    
                  },
                   title: "Send OTP"))
            ],
          ),
        ),
        
      ),
      );
  }

  Future<void> loginUser(String phone, BuildContext context) async {
   
    _auth.verifyPhoneNumber(
      
      phoneNumber: "+92"+phone,
      timeout: const Duration(seconds: 100),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) { 
          Get.offAll(ResetPasswordScreen(emailPhone: _controller.text.trim(), email: widget.email));
         
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
       print("Junaid Token");
       print(resendToken);
       /* Navigator.of(context).pushNamed(HomeScreen.route, arguments: {
          'phoneNumber': _numberController.text,
          'verificationId': verificationId,
          'auth': _auth,
          
        });
        */
        //Get.to(OTPScreen(phoneNumber: phone, verficationID: verificationId,authPre: _auth,));
        Get.to(VerifyOtpScreen(
          email: widget.email,
           emailPhone: _controller.text.trim(),
           verificationID: verificationId,
           auth: _auth,


        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Verification Id of the app");
        print(verificationId);
        setState(() {
          verificationCode = verificationId;
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