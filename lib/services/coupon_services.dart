import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ip.dart' as ip;

class CouponService {
  Future<String> getCoupon() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('user_id') ?? '';

      Map<String, dynamic> jsonMap = <String, dynamic>{
        "user_id": userId,
        "coupon_limit": "5"
      };
      final response = await http.post(
        Uri.parse("${ip.testIP}/create_coupon"),
        body: jsonEncode(jsonMap),
      );

      print("I am receiving Response of Agreement Api ${response.body} ");
      print("Status Code ${response.statusCode}");

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res['code'] == '200') {
          return res['Coupon']['coupon'];
        } else {
          return '';
          // List<MusicGenreModal> genre = _musicGenreFromJson(response.body);
          // return genre;
        }
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return '';
    }
  }
}
