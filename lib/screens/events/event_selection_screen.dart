// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/screens/gallery/gallery_screen.dart';
import 'package:jynx_dj/services/event_service.dart';
import 'package:jynx_dj/widgets/customizebutton.dart';
import 'package:jynx_dj/widgets/drawer.dart';
import 'package:jynx_dj/widgets/reject_button.dart';
class EventSelectionScreen extends StatefulWidget {
  String imageUrl;
  String eventName;
  String eventDate;
  String eventid;
  String djid;
  String eventMonth;
  String startTime;
  String endTime;
  EventSelectionScreen({
    required this.eventDate,
    required this.eventName,
    required this.imageUrl,
    required this.eventid,
    required this.djid,
    required this.startTime,
    required this.endTime,
    required this.eventMonth
  });

  @override
  State<EventSelectionScreen> createState() => _EventSelectionScreenState();
}

class _EventSelectionScreenState extends State<EventSelectionScreen> {

  bool loadData = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B5BA1),
          elevation: 0.0,
          centerTitle: true,
          title: Text(widget.eventName,
          style: GoogleFonts.montserrat().copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: size.width*0.05),
              child: SvgPicture.asset("images/profile.svg",
              height: size.height*0.05,),
            )
          ],
        ),
        drawer: const UserDrawer(),
        
        backgroundColor: const Color(0xFF1B5BA1),
        body: loadData ? const Center(
          child:  CircularProgressIndicator(
            color: Color(0xFF45A1F3),
          ),
        ) 
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height*0.3,
              width: size.width,
              child: Image.network(widget.imageUrl,
              fit: BoxFit.fill,),
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Container(
              height: size.height*0.1,
            //color: Colors.red,
            width: size.width,
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.08),
                    child: Container(
                      height: size.height*0.075,
                      width: size.width*0.12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF46060),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.eventDate,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat().copyWith(color: Colors.white)),
                          
                          Text(widget.eventMonth,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat().copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width*0.03,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: size.width*0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Saturday",
                        style: GoogleFonts.montserrat().copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          
                        ),
                        ),
                        Text(widget.startTime + " - " +widget.endTime,
                        style: GoogleFonts.montserrat().copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          
                        ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height*0.05,
            ),
            Center(child: CustomizeButton(onpress: (){
              acceptEvent(widget.djid, widget.eventid);
            }, title: "Accept"),
            ),
            SizedBox(
              height: size.width*0.04,
            ),
            Center(
              child: RejectButton(onpress: (){
                rejectEvent(widget.djid,widget.eventid);
              }, title: "Reject"),
            ),
          ],
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

  acceptEvent (String djID, String eventID) async{
    setState(() {
      loadData = true;
    });
    var result = await EventService().acceptEvent(djID, eventID);
    if (result == "error")
    {
      Get.snackbar("Error", "Error occured while accepting the Event, please try again",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
    }
    else {
      Get.offAll(const EventScreen());
    }
    setState(() {
      loadData = false;
    });
  }

  rejectEvent (String djID, String eventID) async{
    setState(() {
      loadData = true;
    });
    var result = await EventService().rejectEvent(djID, eventID);
    if (result == "error")
    {
      Get.snackbar("Error", "Error occured while Rejecting the Event, please try again",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6BEAEC),
      duration: const Duration(seconds: 3) );
    }
    else {
      Get.offAll(const EventScreen());
    }
    setState(() {
      loadData = false;
    });

  }

}