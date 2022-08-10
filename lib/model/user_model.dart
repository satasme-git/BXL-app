part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String uid;
  final String stunumber;
  final String email;
  final String fname;
  final String lname;
  final String phone;
  final String homenumber;
  final String image;
  final String token;
  final String signature;
  final String nicfront;
  final String nicback;
  final String address;
  final String roleid;
  final String status;

  UserModel({
    required this.uid,
    required this.stunumber,
    required this.email,
    required this.fname,
    required this.lname,
    required this.phone,
    required this.homenumber,
    required this.image,
    required this.token,
    required this.signature,
    required this.nicfront,
    required this.nicback,
    required this.address,
    required this.roleid,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}


  // receiving data from server
  // UserModel.fromJson(map) {
  //   uid = map['uid'];
  //   email = map['email'];
  //   fname = map['fname'];
  //   lname = map['lname'];
  //   phone = map['phone'];
  //   image = map['image'];
  //   token = map['token'];
  //   signature = map['signature'];
  //   nicfront = map['nicfront'];
  //   nicback = map['nicback'];
  //   status = map['status'];
  //   // userNumber: map['userNumber'],
  // }

  // // sending data to our server
  // Map<String, dynamic> toJson() {
  //   return {
  //     'uid': uid,
  //     'email': email,
  //     'fname': fname,
  //     'lname': lname,
  //     'phone': phone,
  //     'image': image,
  //     'token': token,
  //     'signature': signature,
  //     'nicfront': nicfront,
  //     'nicback': nicback,
  //     'status': status,
  //     // 'userNumber': userNumber
  //   };
  // }
