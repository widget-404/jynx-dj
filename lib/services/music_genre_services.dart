// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jynx_dj/modal/musicGenreModal.dart';
import '../ip.dart' as ip;



class MusicGenreServices {
  Future<List<MusicGenreModal>> getMusicGenre() async {
    // Map<String,dynamic> jsonMap = <String, dynamic>
    // {
    //   "rider_id": riderID
    // };
    final response = await http.get(
      Uri.parse("${ip.testIP}/music_genre"),
    );
    print("I am receiving Response of Music Genre Api ${response.body} ");
    if (response.statusCode == 200) {
      var responseMusicGenre = jsonDecode(response.body);
      if(responseMusicGenre['status'] == 0 )
      {
        return [];
      }
      else
      {

      return  List<MusicGenreModal>.from(responseMusicGenre['genre_list'].map(
        (genres) => MusicGenreModal.fromJson(genres)
      )
      );  
      // List<MusicGenreModal> genre = _musicGenreFromJson(response.body);
      // return genre;
      }
    } else {
      return [];
    }
  }

}
