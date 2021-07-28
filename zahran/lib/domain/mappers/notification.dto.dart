part of 'domain_mapper.dart';

class NotificationDto implements DtoToDomainMapper<NotificationModel> {
  int? id;
  String? type;
  LocalizedNameDto? title;
  LocalizedNameDto? body;
  SenderDto? sender;
  String? sendDate;
  String? sendTime;

  // List<Null> media;

  NotificationDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = LocalizedNameDto.fromJson(json["title"] ?? {});
    body = LocalizedNameDto.fromJson(json["body"] ?? {});
    sender = json['sender'] != null ? new SenderDto.fromJson(json['sender']) : null;
    sendDate = json['send_date'];
    sendTime = json['send_time'];
    // if (json['media'] != null) {
    //   media = new List<Null>();
    //   json['media'].forEach((v) {
    //     media.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['title'] = title?.tojson();
    data['body'] = body?.tojson();
    data['sender'] = sender?.toJson();
    data['send_date'] = sendDate;
    data['send_time'] = sendTime;
    // if (this.media != null) {
    //   data['media'] = this.media.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  @override
  NotificationModel dtoToDomainModel() {
    return NotificationModel(
        id: id!,
        title: title?.dtoToDomainModel() ?? LocalizedName(),
        body: body?.dtoToDomainModel() ?? LocalizedName(),
        type: type ?? "",
        sender: sender!.dtoToDomainModel(),
        sendDate: DateTime.tryParse(sendDate!) ?? DateTime.now(),
        sendTime: DateTime.tryParse(sendTime!) ?? DateTime.now());
  }
}
