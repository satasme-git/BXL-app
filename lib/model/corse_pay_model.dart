import 'package:binary_app/model/cat_model.dart';

class CoursePaymodel {
  late String cpid;
  late String courseFee;
  late String courseName;
  late int pay_amount;
  late int status;
  late String create_at;
  late String updated_at;
  late String uid;
  late String userName;

  CoursePaymodel(
    this.cpid,
    this.courseFee,
    this.courseName,
    this.pay_amount,
    this.status,
    this.create_at,
    this.updated_at,
    this.uid,
    this.userName,
  );

  // receiving data from server
  CoursePaymodel.fromJson(map) {
    cpid = map['cpid'];
    courseFee = map['courseFee'];
    courseName = map['courseName'];
    pay_amount = map['pay_amount'];
    status = map['status'];
    create_at = map['create_at'];
    updated_at = map['updated_at'];
    uid = map['uid'];
    userName = map['userName'];

    // userNumber: map['userNumber'],
  }

  // sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'cpid': cpid,
      'courseFee': courseFee,
      'courseName': courseName,
      'pay_amount': pay_amount,
      'status': status,
      'create_at': create_at,
      'updated_at': updated_at,
      'uid': uid,
      'userName': userName,

      // 'userNumber': userNumber
    };
  }
}
