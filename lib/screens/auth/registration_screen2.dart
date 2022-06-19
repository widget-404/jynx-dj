// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/modal/musicGenreModal.dart';
import 'package:jynx_dj/screens/auth/registration_screen1.dart';
import 'package:jynx_dj/screens/contract/contract_screen.dart';
import 'package:jynx_dj/services/auth_service.dart';
import 'package:jynx_dj/services/music_genre_services.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/registration_step_container.dart';
class RegistrationScreen2 extends StatefulWidget {
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String password;
  String confirmPassword;
  RegistrationScreen2({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.password,
    required this.confirmPassword
  });

  @override
  State<RegistrationScreen2> createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {

  String? musicGenre;
  List<MusicGenreModal> musicGenres =[];
  List<String> genderSelection = ['Male','Female'];
  String? gender;
  bool loadData = false;

  @override
  void initState() {
    
    super.initState();
    setState(() {
      loadData = true;
    });
    initializeData();
  }

  void initializeData () async{
    var response = await MusicGenreServices().getMusicGenre();
    setState(() {
      musicGenres = response;
      loadData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
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
          child: loadData ? const Center(
            child:  CircularProgressIndicator(
              color: Color(0xFF6BEAEC),
            ),
          ) 
          : Padding(
            padding:  EdgeInsets.only(left: size.width*0.075,top: size.height*0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.off(const RegistrationScreen1());
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
                      RegistrationStepContainer(title: "screen2"),
                      SizedBox(
                        height: size.height*0.05,
                      ),
                      Container(
                        width: size.width*0.85,
                        height: size.height*0.075,
                        decoration: BoxDecoration(
                          color: const Color(0xFF143B66),
                          borderRadius: BorderRadius.circular(32)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left: size.width*0.1,right: size.width*0.05),
                          child: DropdownButton<String>(
                  value: musicGenre,
                  hint: Text("Music Genre",
                  style: GoogleFonts.montserrat().copyWith(
                    color: const Color(0xFF6D9EC6),
                    fontSize: 14
                    ),),
                  icon: const Icon(Icons.arrow_drop_down,
                  color:  Color(0xFFC5E3FF),),
                  elevation: 0,
                  dropdownColor: const Color(0xFF143B66),
                  underline: Container(),
                  isExpanded: true,
                  style: GoogleFonts.montserrat().copyWith(
                    color: const Color(0xFF6D9EC6),
                    fontSize: 14.0
                  ),
                  onChanged: (String? newvalue) {
                    setState(() {
                      musicGenre = newvalue!;
                      print(newvalue);
                    });
                  },
                  items: musicGenres.isEmpty ? [] 
                  : musicGenres.map((listItem) => DropdownMenuItem(
                    child: Text(listItem.name),
                    value: listItem.name,)
                    ).toList(),
                ),
                ),
              ),
                      SizedBox(
                        height: size.height*0.03,
                      ),
                      Container(
                        width: size.width*0.85,
                        height: size.height*0.075,
                        decoration: BoxDecoration(
                          color: const Color(0xFF143B66),
                          borderRadius: BorderRadius.circular(32)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left: size.width*0.1,right: size.width*0.05),
                          child: DropdownButton<String>(
                  value: gender,
                  hint: Text("Gender",
                  style: GoogleFonts.montserrat().copyWith(
                    color: const Color(0xFF6D9EC6),
                    fontSize: 14
                    ),),
                  icon: const Icon(Icons.arrow_drop_down,
                  color:  Color(0xFFC5E3FF),),
                  elevation: 0,
                  dropdownColor: const Color(0xFF143B66),
                  underline: Container(),
                  isExpanded: true,
                  style: GoogleFonts.montserrat().copyWith(
                    color: const Color(0xFF6D9EC6),
                    fontSize: 14.0
                  ),
                  onChanged: (String? newvalue) {
                    setState(() {
                      gender = newvalue!;
                      print(newvalue);
                    });
                  },
                  items: genderSelection.map(buildMenuItem).toList(),
                ),
                ),
              ),

              SizedBox(
                height: size.height*0.2,
              ),
              Padding(
                padding:  EdgeInsets.only(left: size.width*0.13),
                child: CustomizeButton(onpress: (){
                  if (!_validator())
                  {
                    return;
                  }
                  registerUser();
                }, title: "Submit"),
              )
                      
                      
              ],
            ),
          ),
        ),
      ),
      );
  }

  void registerUser () async{
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
         musicGenre, gender);
         print("Value of the result $result");
         setState(() {
           loadData = false;
         });
      if (result == "0")
      {
        Get.snackbar("Registration Error", "Error Occured while registration, please try again",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
      } 
      else if (result == "-1")
      {
        Get.snackbar("Email Exit", "Account against given Email has already exist",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
      }
      else {
         Get.snackbar("Registration Successfull", "Registration has completed, have a great experience",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
      // SharedPreference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', result);
      await prefs.setString("login", "true");
      Get.offAll(const ContractScreen());
      }
  }

bool _validator() {
    if (!(musicGenre != null)) {
      Get.snackbar("Music Genre Error", "Please Select Music Genre",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
      return false;
    }
    if (!(gender != null)) {
      Get.snackbar("Gender Error", "Please Select Your Gender",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
      return false;
    }

    return true;
  }

}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item,
    child: Text(
      item,
    ),
  );
}