// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jynx_dj/screens/events/event_screen.dart';
import 'package:jynx_dj/screens/onBoarding/onBoarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  await Firebase.initializeApp();
  
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String login = '';

  @override
  void initState() {
    
    super.initState();
    getIDfromSharedPreference();
  }

  getIDfromSharedPreference () async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getString('login').toString();
    });
    print("Shared Preference DJ ID ${prefs.getString('user_id').toString()}");
    print("Shared Preference Login Value ${prefs.getString('login').toString()}");
  }

  String appid = "346d914e-58bb-407c-875e-e9202378bf8a ";

  @override
  Widget build(BuildContext context) {
    return     GetMaterialApp(
      debugShowCheckedModeBanner: false, 
      title: "JYNX DJ",
      home: login == "true" ? const EventScreen() : const OnBoardingScreen(),
    );
  }
}