part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class MessageModel {
  late String id;
  late String sendarName;
  late String senderid;
  late String image;
  late String message;
  late String messageUrl;
  late String messageType;
  late String messageTime;

  MessageModel(
    this.id,
    this.sendarName,
    this.senderid,
    this.image,
    this.message,
    this.messageUrl,
    this.messageType,
    this.messageTime,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
