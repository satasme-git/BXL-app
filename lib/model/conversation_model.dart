part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class ConversationModel {
  final String id;
  final String conversation_name;
  final String image;
  final List users;
  final List<UserModel> userArray;
  final String lastMessageSender;
  final String lastMessage;
  final String lastMessageTime;
  final String createdBy;
  final String description;
  final int status;

  ConversationModel({
    required this.id,
    required this.conversation_name,
    required this.image,
    required this.users,
    required this.userArray,
    required this.lastMessageSender,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdBy,
    required this.description,
    required this.status,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
