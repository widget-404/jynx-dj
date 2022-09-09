// ignore_for_file: sized_box_for_whitespace

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jynx_dj/modal/eventModel.dart';
import 'package:jynx_dj/modal/notification_model.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/screens/events/event_selection_screen.dart';
import 'package:jynx_dj/screens/gallery/gallery_screen.dart';
import 'package:jynx_dj/services/event_service.dart';
import 'package:jynx_dj/widgets/drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotificationScreen extends StatefulWidget {
  List<NotificationModel> notificationListss;

  NotificationScreen({required this.notificationListss});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationList = [];
  List<EventModel> event = [];
  bool loadData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B5BA1),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Notifications',
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
          child: loadData
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF45A1F3),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            "images/back.svg",
                            height: size.height * 0.05,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.5,
                      child: ListView.builder(
                          itemCount: widget.notificationListss.length,
                          itemBuilder: (context, index) {
                            return widget.notificationListss[index]
                                        .notificationType !=
                                    "5"
                                ? eventRequestCard(
                                    size, widget.notificationListss[index])
                                : eventAcceptCard(
                                    size, widget.notificationListss[index]);
                          }),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.1215,
          width: size.width,
          decoration: const BoxDecoration(color: Color(0xFF143B66)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.offAll(const EventScreen());
                },
                child: SvgPicture.asset(
                  "images/home.svg",
                  height: size.height * 0.03,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(const GalleryScreen());
                },
                child: SvgPicture.asset(
                  "images/ratings.svg",
                  height: size.height * 0.03,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget eventRequestCard(Size size, NotificationModel singleNotification) {
    return GestureDetector(
      onTap: () {
        setState(() {
          singleNotification.status = "1";
        });
        eventScreen(singleNotification.djID, singleNotification.eventId);
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: Container(
            width: size.width * 0.8,
            //height: size.height*0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: singleNotification.status == "0"
                    ? const Color(0xFF6BEAEC)
                    : const Color(0xFF6BEAEC).withOpacity(0.7)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        singleNotification.eventName,
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.06),
                      ),
                      const Spacer(),
                      Text(
                        getDate(singleNotification.createdAt),
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    singleNotification.adminMsg,
                    textAlign: TextAlign.left,
                    style:
                        GoogleFonts.montserrat().copyWith(color: Colors.white),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget eventAcceptCard(Size size, NotificationModel singleNotification) {
    return GestureDetector(
      onTap: () {
        setState(() {
          singleNotification.status = "1";
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.NO_HEADER,
          showCloseIcon: true,
          headerAnimationLoop: false,
          dialogBackgroundColor: const Color(0xFF143B66),
          animType: AnimType.BOTTOMSLIDE,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Your Entrance QR Code is",
                  style: GoogleFonts.montserrat().copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.075,
                    vertical: size.width * 0.05),
                child: QrImage(
                  data: "1",
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(size.width * 0.05),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
                child: Text(
                  "This QR Code is for entrance, present this at the door",
                  style: GoogleFonts.montserrat().copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              )
            ],
          ),
        ).show();
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: Container(
            width: size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: singleNotification.status == "0"
                  ? const Color(0xFF143B66)
                  : const Color(0xFF143B66).withOpacity(0.65),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        singleNotification.eventName,
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.06),
                      ),
                      const Spacer(),
                      Text(
                        getDate(singleNotification.createdAt),
                        style: GoogleFonts.montserrat().copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    singleNotification.adminMsg,
                    textAlign: TextAlign.left,
                    style:
                        GoogleFonts.montserrat().copyWith(color: Colors.white),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void eventScreen(String djID, eventID) async {
    setState(() {
      loadData = true;
    });
    var result = await EventService().singleNotification(djID, eventID);
    setState(() {
      event = result;
      loadData = false;
    });
    if (result.isNotEmpty) {
      Get.to(
        EventSelectionScreen(
          eventDate: event[0].eventDate,
          eventName: event[0].name,
          imageUrl: event[0].imageURL + event[0].eventImage,
          eventid: event[0].id,
          djid: event[0].djid,
          startTime: event[0].startTime,
          endTime: event[0].endTime,
          eventMonth: event[0].eventMonth,
          status: event[0].goingStatus.toString(),
        ),
      );
    }
  }

  String getDate(String createdAt) {
    DateTime date = DateTime.parse(createdAt);
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
