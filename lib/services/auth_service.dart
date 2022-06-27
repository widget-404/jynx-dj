// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../ip.dart' as ip;



class AuthServices {
  
  Future<String> registerUser(String firstName,lastName,phoneNumber,email,password,confirmPassword,musicGenre,gender) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      
    "first_name":firstName,
    "last_name":lastName,
    "email":email,
    "password":password,
    "phone_number":phoneNumber,
    "c_password":confirmPassword,
    "music_genre":musicGenre,
    "gender":gender,
    "representation":"individual"
    };
    print(jsonMap);
    final response = await http.post(
      Uri.parse("${ip.testIP}/register_djuser"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of URL http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/register_djuser ${response.body} ");
    
    print("Status Code of Api ${response.statusCode}");
    
    if (response.statusCode == 200) {
      var responseMusicGenre = jsonDecode(response.body);
      if(responseMusicGenre['status'] == '0' )
      {
        return '0';
      }
      else if (responseMusicGenre['status'] == '2' )
      {
        return "-1";
      }
      else if (responseMusicGenre['status'] == '1' )
      {
        return responseMusicGenre['id'].toString();
      }
      else
      {

        return '0';
      // return  List<MusicGenreModal>.from(responseMusicGenre['genre_list'].map(
      //   (genres) => MusicGenreModal.fromJson(genres)
      // )
      // );  
      // List<MusicGenreModal> genre = _musicGenreFromJson(response.body);
      // return genre;
      }
    } else {
      return '0';
    }
  }

  Future<String> loginUser(String email,password) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
    "phone_number":email,
    "password":password,
    };
    print(jsonMap);
    final response = await http.post(
      Uri.parse("${ip.testIP}/login_djuser"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of Login Api ${response.body} ");
    
    print("Status Code of Api ${response.statusCode}");
    
    if (response.statusCode == 201) {
      var responseMusicGenre = jsonDecode(response.body);
      if(responseMusicGenre['status'] == '0' )
      {
        return '0';
      }
      else if (responseMusicGenre['status'] == '1' )
      {
        return responseMusicGenre['id'].toString();
      }
      else {
        return '0';
      }
    } else {
      return '0';
    }
  }

  Future<String> updatePassword(String email,password) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
    "phone_number":email,
    "password":password,
    };
    print(jsonMap);
    final response = await http.post(
      Uri.parse("${ip.testIP}/update_password"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of Update Password Api ${response.body} ");
    
    print("Status Code of Api ${response.statusCode}");
    
    if (response.statusCode == 200) {
      var responseupdatePassword = jsonDecode(response.body);
      if(responseupdatePassword['message'] == "Password Updated Successfully" )
      {
        return responseupdatePassword['id'].toString();
      }
      else {
        return '0';
      }
    } else {
      return '0';
    }
  }

  Future<String> verifyEmail(String email) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
    "email":email,
    };
    print(jsonMap);
    final response = await http.post(
      Uri.parse("https://jynx.co.za/api/email_verify_mail"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of Verify Email Api ${response.body} ");
    
    print("Status Code of Api ${response.statusCode}");
    
    if (response.statusCode == 200) {
      var responseupdatePassword = jsonDecode(response.body);
      if(responseupdatePassword['code'] == "200" )
      {
        return responseupdatePassword['verify_code'].toString();
      }
      else {
        return '0';
      }
    } else {
      return '0';
    }
  }
  

}
