// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jynx_dj/modal/eventModel.dart';
import 'package:jynx_dj/modal/gallery_image_model.dart';



class GalleryService {
  Future<List<EventModel>> getGalleryEventsList(String djid) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djid
    };
    final response = await http.post(
      Uri.parse("http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/gallery_event_list"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving response of Gallery  Event List Api => ${response.body} ");
    if (response.statusCode == 200) {
      var responseEventList = jsonDecode(response.body);
      if(responseEventList['success'] == true )
      {
        return  List<EventModel>.from(responseEventList['event_list'].map(
        (events) => EventModel.fromJson(events)
      )
      );
      }
      else{
        return [];
      }
      
    } else {
      return [];
    }
  }

  Future<List<GalleryImageModel>> getGalleryEventImages(String djid, String eventid) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djid,
      "event_id": eventid
    };
    final response = await http.post(
      Uri.parse("http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/gallery_event_images"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving response of Gallery  Event Images Api => ${response.body} ");
    if (response.statusCode == 200) {
      var responseEventList = jsonDecode(response.body);
      if(responseEventList['success'] == true )
      {
        return  List<GalleryImageModel>.from(responseEventList['gallery_images'].map(
        (images) => GalleryImageModel.fromJson(images)
      )
      );
      }
      else{
        return [];
      }
      
    } else {
      return [];
    }
  }

}
