import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color(0xFF1B5BA1),
        child: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("login", "false");
            Get.offAll(const LoginScreen());
          },
          child: Padding(
            padding:  EdgeInsets.only(left: size.width*0.1,
            top: size.width*0.075),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.logout_sharp,
                color: Colors.white,
                size: 19,),
                SizedBox(
                  width: size.width*0.02,
                ),
                GestureDetector(
                  onTap: ()async{
                    SharedPreferences prefs =  await SharedPreferences.getInstance();
                    await prefs.setString("login", "false");
                    await prefs.setString("user_id", "0");
                    Get.offAll(const LoginScreen());
                  },
                  child: Text(
                    "Sign Out",
                    style: GoogleFonts.montserrat()
                        .copyWith(
                          color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
