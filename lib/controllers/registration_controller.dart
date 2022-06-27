import 'dart:async';
import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import '../ip.dart' as ip;
import 'package:shared_preferences/shared_preferences.dart';


class RegistationController extends GetxController {
  // ignore: deprecated_member_use
 
  var isNumberVerified = false.obs;
}