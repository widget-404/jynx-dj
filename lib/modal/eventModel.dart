
class EventModel {
    EventModel({
        required this.name,
        required this.id,
        required this.description,
        required this.djid,
        required this.eventDate,
        required this.eventImage,
        required this.goingStatus,
        required this.shortDesription,
        required this.imageURL,
        required this.startTime,
        required this.endTime,
        required this.eventMonth,
        required this.qrCodeStatus


    });

    String id;
    String name;
    String description;
    String shortDesription;
    String eventImage;
    String imageURL;
    String djid;
    String eventMonth;
    String goingStatus;
    String eventDate;
    String startTime;
    String endTime;
    String qrCodeStatus;


    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        name: json['event_name'].toString(),
        id: json["id"].toString(),
        description: json['event_description'].toString(),
        shortDesription: json['event_short_description'].toString(),
        eventImage: json['event_image'].toString(),
        djid: json['dj_id'].toString(),
        goingStatus: json['going_status'].toString(),
        eventDate: json['event_date_daY'].toString(),
        eventMonth: json['event_date_month'].toString(),
        imageURL: json['image_url'].toString(),
        startTime: json['event_start_time'].toString(),
        endTime: json['event_end_time'].toString(),
        qrCodeStatus: json['dj_qr_code_status'].toString(),
    );
}



