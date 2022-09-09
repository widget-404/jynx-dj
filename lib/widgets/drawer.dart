import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/auth/login_screen.dart';
import 'package:jynx_dj/screens/invite_coupon/invite_counpon_page.dart';
import 'package:jynx_dj/screens/invite_coupon/invite_coupon_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  String userName = '';

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('user_name') ?? '';
    setState(() {});
  }

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
            padding: EdgeInsets.only(
                left: size.width * 0.1, top: size.width * 0.075),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: GoogleFonts.montserrat().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.logout_sharp,
                      color: Colors.white,
                      size: 19,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString("login", "false");
                        await prefs.setString("user_id", "0");
                        Get.offAll(const LoginScreen());
                      },
                      child: Text(
                        "Log Out",
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.discount,
                      color: Colors.white,
                      size: 19,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.lazyPut<InviteCouponController>(
                            () => InviteCouponController());
                        Get.to(() => const InviteCouponPage());
                      },
                      child: Text(
                        "Invite Coupons",
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
