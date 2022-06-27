// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../ip.dart' as ip;




class DeviceidService {
  Future<String> registerDevice(String djID, String deviceID) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djID,
      "device_id": deviceID
    };
    
    final response = await http.post(
      Uri.parse("${ip.testIP}/register_device"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of Register Device Api => ${response.body} ");
    print("Status Code ${response.statusCode}");
    
    if (response.statusCode == 201) {
      var responseRegisterDevice = jsonDecode(response.body);
      return responseRegisterDevice['message'];
    } else {
      return "";
    }
  }

  

}
