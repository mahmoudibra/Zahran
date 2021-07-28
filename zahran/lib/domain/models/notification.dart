part of 'models.dart';

class NotificationModel {
  int id;
  String type;
  LocalizedName title;
  LocalizedName body;
  Sender sender;
  DateTime sendDate;
  DateTime sendTime;

  // List<Null> media;

  NotificationModel(
      {required this.id,
      required this.type,
      required this.title,
      required this.body,
      required this.sender,
      required this.sendDate,
      required this.sendTime});

  factory NotificationModel.empty() {
    return NotificationModel(
      id: 0,
      sendDate: DateTime.now(),
      sendTime: DateTime.now(),
      sender: Sender(avatar: '', name: ''),
      type: "",
      title: LocalizedName(),
      body: LocalizedName(),
    );
  }
}
