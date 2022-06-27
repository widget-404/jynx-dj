// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/modal/notification_model.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/screens/gallery/gallery_screen.dart';
import 'package:jynx_dj/widgets/drawer.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<NotificationModel> notificationList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B5BA1),
          elevation: 0.0,
          centerTitle: true,
          title: Text('Notifications',
          style: GoogleFonts.montserrat().copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          
        ),
        drawer: const UserDrawer(),
        body: Container(
          width: size.width,
          height: size.height,
          color: const Color(0xFF1B5BA1),
          child: Column(
            children: [
              Container(
                height: size.height*0.5,
                child: ListView.builder(
                  itemCount: 0,
                  itemBuilder: (context,index){
                  return Container();
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
                height: size.height*0.1215,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF143B66)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        Get.offAll(const EventScreen());
                      },
                      child: SvgPicture.asset("images/home.svg",
                      height: size.height*0.03,),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.offAll(const GalleryScreen());
                      },
                      child: SvgPicture.asset("images/ratings.svg",
                      height: size.height*0.03,),
                    )
                  ],
                ),
              ),
      ),
      );
  }

  Widget eventRequestCard (Size size) {
    return Container(
      width: size.width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        
      ),
    );
  }

}