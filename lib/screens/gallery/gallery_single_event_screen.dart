// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:jynx_dj/modal/gallery_image_model.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/screens/gallery/gallery_screen.dart';
import 'package:jynx_dj/services/gallery_service.dart';
import 'package:jynx_dj/widgets/customize_icon_container.dart';
import 'package:jynx_dj/widgets/drawer.dart';
import 'package:jynx_dj/widgets/gallery_event_image_card.dart';
import 'package:jynx_dj/widgets/image_mover_container.dart';
import 'package:share_plus/share_plus.dart';

class GallerySingleEventScreen extends StatefulWidget {
  String djID;
  String eventID;
  String eventName;
  String eventDate;
  String eventMonth;
  String imageBaseUrl;
  String goingStatus;
  GallerySingleEventScreen(
      {required this.djID,
      required this.eventDate,
      required this.eventID,
      required this.eventMonth,
      required this.eventName,
      required this.imageBaseUrl,
      required this.goingStatus});

  @override
  State<GallerySingleEventScreen> createState() =>
      _GallerySingleEventScreenState();
}

class _GallerySingleEventScreenState extends State<GallerySingleEventScreen> {
  bool loadData = false;
  List<GalleryImageModel> imageList = [];
  int currentindex = 0;

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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFF1B5BA1),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.05,
              ),
              child: SvgPicture.asset(
                "images/profile.svg",
                height: size.height * 0.05,
              ),
            )
          ],
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.04, top: size.height * 0.01),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "images/back.svg",
                          height: size.height * 0.05,
                        ),
                        SizedBox(
                          width: size.width * 0.075,
                        ),
                        Text(
                          widget.eventName + " - ",
                          style: GoogleFonts.montserrat().copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.eventDate + " " + widget.eventMonth,
                          style: GoogleFonts.montserrat()
                              .copyWith(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    height: size.height * 0.71755,
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, right: size.width * 0.05),
                      child: GridView.builder(
                        itemCount: imageList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.0,
                                childAspectRatio: 0.99,
                                mainAxisSpacing: 12.0),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentindex = index;
                                });
                                print(
                                    "Current Index at the start $currentindex");
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(builder: (context, setState){
                                        return Dialog(
                                        backgroundColor:
                                            const Color(0xFF1B5BA1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        insetPadding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0, top: 3.0),
                                          child: Container(
                                            height: size.height * 0.45,
                                            width: size.width * 0.9,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0.0,
                                                  child: Container(
                                                    height: size.height * 0.395,
                                                    width: size.width * 0.89,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        color: const Color(
                                                            0xFF1B5BA1)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.network(
                                                          widget.imageBaseUrl +
                                                              imageList[
                                                                      currentindex]
                                                                  .imageUrl,
                                                          fit: BoxFit.fill,
                                                        )),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0.0,
                                                  top: 10.0,
                                                  child: CustomeIconContainer(
                                                    onpress: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icons.close,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0.0,
                                                  top: size.height * 0.18,
                                                  child: ImageMoverContainer(
                                                      onpress: () {
                                                        if (currentindex > 0) {
                                                          setState(() {
                                                            currentindex--;
                                                          });
                                                          print(
                                                              "Current Index at the back $currentindex");
                                                        }
                                                      },
                                                      icon:
                                                          Icons.arrow_back_ios),
                                                ),
                                                Positioned(
                                                  right: 0.0,
                                                  top: size.height * 0.18,
                                                  child: ImageMoverContainer(
                                                      onpress: () {
                                                        if (currentindex <
                                                            imageList.length -
                                                                1) {
                                                          setState(() {
                                                            currentindex++;
                                                          });
                                                          print(
                                                              "Current Index at the forwad $currentindex");
                                                        }
                                                      },
                                                      icon: Icons
                                                          .arrow_forward_ios),
                                                ),
                                                Positioned(
                                                    bottom: 5.0,
                                                    right: 5.0,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        CustomeIconContainer(
                                                            icon:
                                                                Icons.download,
                                                            onpress: () async {
                                                             
                                                              try {
                                                                var imageId = await ImageDownloader.downloadImage(widget
                                                                        .imageBaseUrl +
                                                                    imageList[
                                                                            currentindex]
                                                                        .imageUrl);
                                                                if (imageId ==
                                                                    null) {
                                                                  return;
                                                                }
                                                                Get.snackbar(
                                                                    "Image Save",
                                                                    "Image has been saved successfully, kindly check your storage",
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xFF6BEAEC),
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            3));
                                                                // Below is a method of obtaining saved image information.
                                                                var fileName =
                                                                    await ImageDownloader
                                                                        .findName(
                                                                            imageId);
                                                                var path =
                                                                    await ImageDownloader
                                                                        .findPath(
                                                                            imageId);
                                                                var size = await ImageDownloader
                                                                    .findByteSize(
                                                                        imageId);
                                                                var mimeType =
                                                                    await ImageDownloader
                                                                        .findMimeType(
                                                                            imageId);
                                                                Navigator.pop(context);
                                                              } on PlatformException catch (error) {
                                                                print(error);
                                                              }
                                                            }),
                                                        CustomeIconContainer(
                                                            icon: Icons.share,
                                                            onpress: () async{
                                                              final box = context.findRenderObject() as RenderBox?;
                                                              var imageID = await ImageDownloader.downloadImage(widget.imageBaseUrl+imageList[currentindex].imageUrl);
                                                              var path = await ImageDownloader.findPath(imageID!);
                                                              print("Path of thee image $path");
                                                              Share.shareFiles([path!],
                                                              //sharePositionOrigin:
                                                               );
                                                            }),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                      });
                                    });
                              },
                              child: GalleryEventImageCard(
                                  imageUrl: widget.imageBaseUrl +
                                      imageList[index].imageUrl));
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
              GestureDetector(
                onTap: () {
                  Get.off(const GalleryScreen());
                },
                child: SvgPicture.asset(
                  "images/gallery.svg",
                  height: size.height * 0.03,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  initialData() async {
    setState(() {
      loadData = true;
    });
    getImages();
  }

  getImages() async {
    var result = await GalleryService()
        .getGalleryEventImages(widget.djID, widget.eventID);
    setState(() {
      imageList = result;
      loadData = false;
    });
  }
}
