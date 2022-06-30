// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as String,
      conversation_name: json['conversation_name'] as String,
      image: json['image'] as String,
      users: json['users'] as List<dynamic>,
      userArray: (json['userArray'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e))
          .toList(),
      lastMessageSender: json['lastMessageSender'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: json['lastMessageTime'] as String,
      createdBy: json['createdBy'] as String,
      description: json['description'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_name': instance.conversation_name,
      'image': instance.image,
      'users': instance.users,
      'userArray': instance.userArray.map((e) => e.toJson()).toList(),
      'lastMessageSender': instance.lastMessageSender,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'createdBy': instance.createdBy,
      'description': instance.description,
      'status': instance.status,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['id'] as String,
      json['sendarName'] as String,
      json['senderid'] as String,
      json['image'] as String,
      json['message'] as String,
      json['messageUrl'] as String,
      json['messageType'] as String,
      json['messageTime'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sendarName': instance.sendarName,
      'senderid': instance.senderid,
      'image': instance.image,
      'message': instance.message,
      'messageUrl': instance.messageUrl,
      'messageType': instance.messageType,
      'messageTime': instance.messageTime,
    };

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      Fee: json['Fee'] as String,
      VideoName: json['VideoName'] as String,
      corseid: json['corse_id'] as String,
      coursename: json['course_name'] as String,
      image: json['image'] as String,
      vid: json['vid'] as String,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'Fee': instance.Fee,
      'VideoName': instance.VideoName,
      'corse_id': instance.corseid,
      'course_name': instance.coursename,
      'image': instance.image,
      'vid': instance.vid,
    };
