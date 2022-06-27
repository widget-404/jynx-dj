
class NotificationModel {
  int id;
  String userId;
  String notificationType;
  String eventId;
  String eventName;
  String eventDescription;
  String eventDate;
  String adminMsg;
  String itemId;
  String itemName;
  String itemDescription;
  String itemQrCode;
  String status;
  String djID;
  String createdAt;
  String updatedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.notificationType,
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.adminMsg,
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.itemQrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.djID
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json['id'],
        userId: json['user_id'].toString(),
        djID: json['dj_id'].toString(),
        notificationType: json['notification_type'].toString(),
        eventId: json['event_id'].toString(),
        eventName: json['event_name'].toString(),
        eventDescription: json['event_description'].toString(),
        eventDate: json['event_date'].toString(),
        adminMsg: json['admin_msg'].toString(),
        itemId: json['item_id'].toString(),
        itemName: json['item_name'].toString(),
        itemDescription: json['item_description'].toString(),
        itemQrCode: json['item_qr_code'].toString(),
        status: json['status'].toString(),
        createdAt: json['created_at'].toString(),
        updatedAt: json['updated_at'].toString()
        
        
        
    );

  
}
