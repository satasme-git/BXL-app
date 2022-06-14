class ChatGroupModel {
  late String cgid;
  late String group_info;
  late String group_name;
  late String image;
  late String last_msg;
  late String last_uid;
  late String lastseen;
  late int status;

  ChatGroupModel(
    this.cgid,
    this.group_info,
    this.group_name,
    this.image,
    this.last_msg,
    this.last_uid,
    this.lastseen,
    this.status,
  );

  // receiving data from server
  ChatGroupModel.fromJson(map) {
    cgid = map['cgid'];
    group_info = map['group_info'];
    group_name = map['group_name'];
    image = map['image'];
    last_msg = map['last_msg'];
    last_uid = map['last_uid'];
    lastseen = map['lastseen'];
    status = map['status'];
    // userNumber: map['userNumber'],
  }

  // sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'cgid': cgid,
      'email': group_info,
      'fname': group_name,
      'image': image,
      'last_msg': last_msg,
      'last_uid': last_uid,
      'lastseen': lastseen,
      'status': status,
      // 'userNumber': userNumber
    };
  }
}
