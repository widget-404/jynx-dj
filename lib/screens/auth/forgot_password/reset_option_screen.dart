import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/forgot_password/email_phone_screen.dart';
import 'package:jynx_dj/widgets/back_container.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';

class ResetOptionScreen extends StatefulWidget {
  const ResetOptionScreen({Key? key}) : super(key: key);

  @override
  State<ResetOptionScreen> createState() => _ResetOptionScreenState();
}

class _ResetOptionScreenState extends State<ResetOptionScreen> {
  bool sms = true;
  bool email = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              top: size.height * 0.02,
              left: size.width * 0.075,
              right: size.width * 0.05),
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1B5BA1), Color(0xFF011021)],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: SvgPicture.asset("images/back.svg")),
              SizedBox(
                height: size.height * 0.025,
              ),
              Text(
                "Choose Verification ",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.085,
                ),
              ),
              Text(
                "Option",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.085,
                ),
              ),
              SizedBox(
                height: size.height * 0.012,
              ),
              Text(
                "Select the verification option",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontSize: size.width * 0.045,
                ),
              ),
              Text(
                "below.",
                style: GoogleFonts.montserrat().copyWith(
                  color: Colors.white,
                  fontSize: size.width * 0.045,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sms = true;
                        email = false;
                      });
                    },
                    child: Container(
                      width: size.width * 0.1,
                      height: size.height * 0.035,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: sms
                          ? const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Text(
                    "Verify through SMS.",
                    style: GoogleFonts.montserrat().copyWith(
                        color: Colors.white, fontSize: size.width * 0.05),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sms = false;
                        email = true;
                      });
                    },
                    child: Container(
                      width: size.width * 0.1,
                      height: size.height * 0.035,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: email
                          ? const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Text(
                    "Verify through Email.",
                    style: GoogleFonts.montserrat().copyWith(
                        color: Colors.white, fontSize: size.width * 0.05),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Center(
                child: CustomizeButton(
                    onpress: () {
                      if (email) {
                        error("Verification through email is remaining", size);
                      } else {
                        Get.to(EmailPhoneScreen(email: false));
                      }
                    },
                    title: "Enter"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  error(String discription, Size size) {
    return AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.ERROR,
        showCloseIcon: true,
        animType: AnimType.BOTTOMSLIDE,
        body: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text(
                discription,
                style: GoogleFonts.montserrat().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        )).show();
  }
}
