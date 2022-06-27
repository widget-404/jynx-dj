// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jynx_dj/modal/eventModel.dart';
import 'package:jynx_dj/modal/notification_model.dart';
import 'package:jynx_dj/screens/contract/contract_screen.dart';
import 'package:jynx_dj/screens/gallery/gallery_screen.dart';
import 'package:jynx_dj/screens/notifications/notification_screen.dart';
import 'package:jynx_dj/services/contract_service.dart';
import 'package:jynx_dj/services/device_id_service.dart';
import 'package:jynx_dj/services/event_service.dart';
import 'package:jynx_dj/widgets/drawer.dart';
import 'package:jynx_dj/widgets/events_card.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EventScreen extends StatefulWidget {
  const EventScreen({ Key? key }) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  bool loadData = false;
  List<EventModel> eventList = [];
  String djID = "";
  List<NotificationModel> notificationList = [];
  String _playerid = "";
  bool noData = false; 

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
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B5BA1),
          elevation: 0.0,
          centerTitle: true,
          title: Text('Event Requests',
          style: GoogleFonts.montserrat().copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          actions: [
            // Padding(
            //   padding:  EdgeInsets.only(right: size.width*0.05),
            //   child: SvgPicture.asset("images/profile.svg",
            //   height: size.height*0.05,),
            // ),
            GestureDetector(
              onTap: (){
                Get.to(const NotificationScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(right: size.width*0.05),
                child: const Icon(Icons.notifications,
                color: Colors.white,),
              ),
            ),
          ],
        ),
        drawer: const UserDrawer(),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Color(0xFF1B5BA1),
              //image: DecorationImage(image: AssetImage("images/Getstarted.png")),
              // gradient: LinearGradient(
              //   colors: [
              //       Color(0xFF1B5BA1),
              //       Color(0xFF011021)
              //     ],
              //     begin: Alignment.center,
              //     end: Alignment.bottomCenter
              //   ),
                ),
          child: loadData ? const Center(
            child:  CircularProgressIndicator(
              color: Color(0xFF45A1F3),
            ),
          )  
          : Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: size.width*0.04,top: size.height*0.02,right: size.width*0.05),
                child: Column(
                  children: [
                    
                    Container(
                      height: size.height*0.74,
                      width:  size.width,
                      child: noData ? Center(
                        child: Text("No Current Events",
                        style: GoogleFonts.montserrat().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                        )
                      )
                       : GridView.builder(
                        itemCount: eventList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
                        crossAxisCount: 2,  
                        crossAxisSpacing:14.0,
                        childAspectRatio: 0.85,  
                        mainAxisSpacing: 20.0  
                    ),
                      itemBuilder: (context, index) {
                        return  EventCard(
                          imageUrl: eventList[index].imageURL + eventList[index].eventImage,
                          eventName: eventList[index].name,
                          eventDate: eventList[index].eventDate,
                          djStatus: eventList[index].goingStatus.toString(),
                          eventMonth: eventList[index].eventMonth,
                          djid: djID.toString(),
                          eventid: eventList[index].id,
                          startTime: eventList[index].startTime,
                          endTime: eventList[index].endTime,
                        );
                      },
                      )
                    ),
                    
                  ],
                ),
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
                    SvgPicture.asset("images/home.svg",
                    height: size.height*0.03,),
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

  initialData () async{
    if(mounted)
    {
      SharedPreferences prefs =  await SharedPreferences.getInstance();
    setState(() {
      djID = prefs.getString('user_id').toString();
    });
    await configOneSignal();
    await getPlayerID();
    await registerDevice();
    await checkAgreementStatus(djID);
    await getEventLists(djID);
    await notificaitonList("1");
    }
  }

  getEventLists(String djid) async{
    if (mounted)
    {
      setState(() {
      loadData = true;
    });
    var result = await EventService().getEventsList(djid);
    print("Result => $result");
    if (result.isEmpty)
    {
      setState(() {
        noData = true;
        loadData = false;
      });
    }
    else{
      setState(() {
      eventList = result;
      loadData = false;
    });
    }
    }
    
  }

  notificaitonList (String djID) async{
    var result = await EventService().notification(djID);
    setState(() {
      notificationList = result;
      print("Length of the notificaiton List ${notificationList.length}");
    });
  }

  checkAgreementStatus (String djID) async{
    print("Check function start");
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var status = prefs.getString("agreement").toString();
    print("Stauts of Agreement value $status");
    if (status == "accept")
    {
           return ; 
    }
    print("Agreement Status Check Function");
    var result = await ContractService().checkContractStatus(djID);
    if (result == "error" || result == "false")
    {
      Get.offAll(const ContractScreen());
    }
    else{
      return;
    }

  }

  
    Future<void> configOneSignal() async {

    if (!mounted) {
      return;
    }

    await OneSignal.shared.setAppId(
      '346d914e-58bb-407c-875e-e9202378bf8a',
    );

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
        event.complete(event.notification);
        event.notification.priority = 10;
        final notify = event.notification.jsonRepresentation().replaceAll('\\n', '\n');
  print(notify);                                 
});
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    ); //Remove if necessary

   
  }

  Future<void> getPlayerID() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      _playerid = status!.userId.toString();
    });

    print('Player ID : $_playerid');
  }

  Future<void> registerDevice () async{
    var result = await DeviceidService().registerDevice(djID, _playerid);
    print(result);
  }

}