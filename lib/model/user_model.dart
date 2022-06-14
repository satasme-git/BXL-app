class UserModel {
  late String uid;
  late String email;
  late String fname;
  late String lname;
  late String phone;
  late String image;
  late String token;
  late String status;

  UserModel(
    this.uid,
    this.email,
    this.fname,
    this.lname,
    this.phone,
    this.image,
    this.token,
    this.status,
  );

  // receiving data from server
  UserModel.fromJson(map) {
    uid = map['uid'];
    email = map['email'];
    fname = map['fname'];
    lname = map['lname'];
    phone = map['phone'];
    image = map['image'];
    token = map['token'];
    status = map['status'];
    // userNumber: map['userNumber'],
  }

  // sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fname': fname,
      'lname': lname,
      'phone': phone,
      'image': image,
      'token': token,
      'status': status,
      // 'userNumber': userNumber
    };
  }
}
