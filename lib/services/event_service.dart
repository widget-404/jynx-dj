// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jynx_dj/modal/eventModel.dart';
import 'package:jynx_dj/modal/notification_model.dart';
import '../ip.dart' as ip;



class EventService {
  Future<List<EventModel>> getEventsList(String djid) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djid
    };
    final response = await http.post(
      Uri.parse("${ip.testIP}/dj_event_list_api"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving response of Event List Api => ${response.body} ");
    if (response.statusCode == 200) {
      var responseEventList = jsonDecode(response.body);
      if(responseEventList['success'] == true )
      {
        return  List<EventModel>.from(responseEventList['event_list'].map(
        (genres) => EventModel.fromJson(genres)
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

  Future<String> acceptEvent(String djid, String eventid) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "dj_id": djid,
      "event_id" : eventid
    };
    print("Going Map  => $jsonMap");
    final response = await http.post(
      Uri.parse("${ip.testIP}/accept_event"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving response of Event Accept Api => ${response.body} ");
    print("Status Code => ${response.statusCode}");
    if (response.statusCode == 200) {
      var responseEventAccept = jsonDecode(response.body);
      if(responseEventAccept['message'] == "Event Accepted" )
      {
        return "true";
      }
      else{
        return "error";
      }
      
      
    } else {
      return "error";
    }
  }

  Future<String> rejectEvent(String djid, String eventid) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "dj_id": djid,
      "event_id" : eventid
    };
    final response = await http.post(
      Uri.parse("${ip.testIP}/reject_event"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving response of Event Reject Api => ${response.body} ");
    if (response.statusCode == 200) {
      var responseEventReject = jsonDecode(response.body);
      if(responseEventReject['message'] == "Event Rejected" )
      {
        return "true";
      }
      else{
        return "error";
      }
      
      
    } else {
      return "error";
    }
  }

  Future<List<NotificationModel>> notification (String djid) async{
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "dj_id": djid,
      
    };
    final response = await http.post(Uri.parse("${ip.testIP}/dj_notifications"),
    body: jsonEncode(jsonMap)
    );
    
    print("I am receiving response of Notification List Api => ${response.body} ");
    if (response.statusCode == 200)
    {
      var responseNotificationList = jsonDecode(response.body);
      return  List<NotificationModel>.from(responseNotificationList['Notification List'].map(
        (genres) => NotificationModel.fromJson(genres)
      )
      );
    }
    else {
      return [];
    }

  }

  Future<List<EventModel>> singleNotification (String djid, String eventid) async{
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "dj_id": djid,
      "event_id": eventid
      
    };
    final response = await http.post(Uri.parse("${ip.testIP}/one_event"),
    body: jsonEncode(jsonMap)
    );
    
    print("I am receiving response of Single Event  Api => ${response.body} ");
    if (response.statusCode == 200)
    {
      var responseNotificationList = jsonDecode(response.body);
      return  List<EventModel>.from(responseNotificationList['event_list'].map(
        (genres) => EventModel.fromJson(genres)
      )
      );
    }
    else {
      return [];
    }

  }

  Future<String> bookingID(String djid, String eventid) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djid,
      "event_id" : eventid
    };
    final response = await http.post(
      Uri.parse("${ip.testIP}/dj_booking_id"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving response of Booking ID Api => ${response.body} ");
    if (response.statusCode == 200) {
      var responseBookingID = jsonDecode(response.body);
      if(responseBookingID['success'] == true)
      {
        return responseBookingID['booking_id'][0]['booking_id'];
      }
      else{
        return "error";
      }
      
      
    } else {
      return "error";
    }
  }
}
