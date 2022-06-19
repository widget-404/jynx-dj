// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jynx_dj/modal/musicGenreModal.dart';



class MusicGenreServices {
  Future<List<MusicGenreModal>> getMusicGenre() async {
    // Map<String,dynamic> jsonMap = <String, dynamic>
    // {
    //   "rider_id": riderID
    // };
    final response = await http.get(
      Uri.parse("http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/music_genre"),
    );
    print("I am receiving Response of URL http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/music_genre ${response.body} ");
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
