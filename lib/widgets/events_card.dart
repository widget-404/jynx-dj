// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/events/event_selection_screen.dart';
class EventCard extends StatefulWidget {
  String imageUrl;
  String eventDate;
  String eventName;
  String djStatus;
  String eventid;
  String djid;
  String startTime;
  String endTime;
  String eventMonth;

  EventCard({
    required this.imageUrl,
    required this.eventName,
    required this.eventDate,
    required this.djStatus,
    required this.eventid,
    required this.djid,
    required this.startTime,
    required this.endTime,
    required this.eventMonth
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.5,
      height: size.height*0.35,
      decoration:  BoxDecoration(
        color: const Color(0xFF143B66),
        borderRadius: BorderRadius.circular(32)
      ),
      child: Column(
        children: [
          Container(
            height: size.height*0.16,
            width: size.width*0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              //color: Colors.red
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16)
              ),
              child: Image.network(widget.imageUrl,
              fit: BoxFit.fill,),
            ),
          ),
          Container(
            height: size.height*0.1,
            //color: Colors.red,
            width: size.width*0.5,
            child: Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: size.width*0.05),
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
                Padding(
                  padding: EdgeInsets.only(left: size.width*0.02,
                  top: size.width*0.02),
                  child: Container(
                    width: size.width*0.23,
                    height: size.height*0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.eventName,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.montserrat().copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(
                          height: size.width*0.01,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: size.width*0.01),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(EventSelectionScreen(
                                eventDate: widget.eventDate,
                                djid: widget.djid,
                                status: widget.djStatus,
                                eventid: widget.eventid,
                                 eventName: widget.eventName,
                                  imageUrl: widget.imageUrl,
                                  startTime: widget.startTime,
                                  eventMonth: widget.eventMonth,
                                  endTime: widget.endTime,),
                                  );
                            },
                            child: Container(
                              height: size.height*0.03,
                              width: size.width*0.23,
                              decoration: BoxDecoration(
                                color: widget.djStatus == "1"  ? const Color(0xFF6BEAEC) : const Color(0xFFF46060),
                                borderRadius: BorderRadius.circular(32)
                              ),
                              child: widget.djStatus == "1" ? Center(
                                child: Text("Going",
                                style: GoogleFonts.montserrat().copyWith(
                                  color: Colors.white,
                                  fontSize: 11.5
                                ),
                                )
                              )
                              :  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Going",
                                  style: GoogleFonts.montserrat().copyWith(
                                    color: Colors.white,
                                    fontSize: 11.5
                                  ),
                                  
                                  ),
                                  SizedBox(
                                    width: size.width*0.01,
                                  ),
                                  SvgPicture.asset("images/question.svg")
                                ],
                              ),
                            ),
                          ),
                          
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}