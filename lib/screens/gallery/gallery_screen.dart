// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/modal/eventModel.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/services/gallery_service.dart';
import 'package:jynx_dj/widgets/drawer.dart';
import 'package:jynx_dj/widgets/events_card.dart';
import 'package:jynx_dj/widgets/gallery_event_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<EventModel> galleryEventsList = [];
  String djID = "";
  bool loadData = false;

  @override
  void initState() {
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1B5BA1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.33),
          child: AppBar(
            elevation: 0.0,
            //toolbarHeight: size.height*0.3,
            // title: Center(
            //   //child: Text("Gallery",
            //   style: GoogleFonts.montserrat().copyWith(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold
            //   ),
            //   ),
            //   ),
            //backgroundColor: const Color(0xFF1B5BA1),
            flexibleSpace: Container(
                width: size.width,
                height: size.height * 0.33,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          const Color(0xFF74F9B8).withOpacity(0.5),
                          BlendMode.dstATop),
                      image: const AssetImage(
                        "images/galback.png",
                      ),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.25),
                  child: Text(
                    "Gallery",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat().copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),

            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.05,
                ),
                child: SvgPicture.asset(
                  "images/profile.svg",
                  height: size.height * 0.04,
                ),
              )
            ],
          ),
        ),
        drawer: const UserDrawer(),
        body: loadData
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF45A1F3),
                ),
              )
            : Column(
                children: [
                  //const GalleryImageContainer(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Expanded(
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      child: GridView.builder(
                        itemCount: galleryEventsList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14.0,
                          childAspectRatio: 0.85,
                          mainAxisSpacing: 20.0,
                        ),
                        itemBuilder: (context, index) {
                          return GalleryEventCard(
                            imageUrl: galleryEventsList[index].imageURL +
                                galleryEventsList[index].eventImage,
                            eventName: galleryEventsList[index].name,
                            eventMonth: galleryEventsList[index].eventMonth,
                            eventDate: galleryEventsList[index].eventDate,
                            djStatus:
                                galleryEventsList[index].goingStatus.toString(),
                            djid: djID.toString(),
                            eventid: galleryEventsList[index].id,
                            startTime: galleryEventsList[index].startTime,
                            endTime: galleryEventsList[index].endTime,
                            imageMainUrl: galleryEventsList[index].imageURL,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: Container(
          height: size.height * 0.08467,
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
                  color: const Color(0xFF65ABCE),
                ),
              ),
              SvgPicture.asset(
                "images/gallery.svg",
                height: size.height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }

  void initialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loadData = true;
      djID = prefs.getString("userid").toString();
    });

    var result = await GalleryService().getGalleryEventsList("1");
    setState(() {
      galleryEventsList = result;
      loadData = false;
    });
  }
}
