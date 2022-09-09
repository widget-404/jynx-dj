// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/screens/events/event_selection_screen.dart';
import 'package:jynx_dj/screens/gallery/gallery_single_event_screen.dart';

class GalleryEventCard extends StatefulWidget {
  String imageUrl;
  String eventDate;
  String eventMonth;
  String eventName;
  String djStatus;
  String eventid;
  String djid;
  String startTime;
  String endTime;
  String imageMainUrl;

  GalleryEventCard(
      {required this.imageUrl,
      required this.eventName,
      required this.eventDate,
      required this.djStatus,
      required this.eventid,
      required this.djid,
      required this.eventMonth,
      required this.startTime,
      required this.endTime,
      required this.imageMainUrl});

  @override
  State<GalleryEventCard> createState() => _GalleryEventCardState();
}

class _GalleryEventCardState extends State<GalleryEventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(
          GallerySingleEventScreen(
            djID: widget.djid,
            eventID: widget.eventid,
            eventName: widget.eventName,
            eventDate: widget.eventDate,
            eventMonth: widget.eventMonth,
            imageBaseUrl: widget.imageMainUrl,
            goingStatus: widget.djStatus,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF143B66),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Container(
              height: size.height * 0.16,
              width: size.width * 0.5,
              child: Stack(
                children: [
                  Positioned(
                    //top: 0.0,
                    child: Container(
                      height: size.height * 0.16,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        //color: Colors.red
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  widget.djStatus == "1"
                      ? Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            height: size.height * 0.04,
                            width: size.width * 0.2,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF46060),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                "Attended",
                                style: GoogleFonts.montserrat().copyWith(
                                    color: Colors.white, fontSize: 11),
                              ),
                            ),
                          ))
                      : Container(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.12,
                        margin: EdgeInsets.only(left: size.width * 0.05),
                        decoration: BoxDecoration(
                          color: widget.djStatus == "1"
                              ? const Color(0xFFF46060)
                              : const Color(0xFF6BEAEC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.eventDate,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat().copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.eventMonth,
                              //textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat().copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.22,
                        padding: EdgeInsets.only(
                          left: size.width * 0.04,
                        ),
                        child: Text(
                          widget.eventName,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
