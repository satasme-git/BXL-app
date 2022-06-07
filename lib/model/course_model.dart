import 'package:binary_app/model/cat_model.dart';

class Coursemodel {
  late String cid;
  late String CourseFee;
  late String CourseName;
  late String duration;
  late String image;
  late String instructor;

  Coursemodel(
    this.cid,
    this.CourseFee,
    this.CourseName,
    this.duration,
    this.image,
    this.instructor,
  );

  // receiving data from server
  Coursemodel.fromJson(map) {
    cid = map['cid'];
    CourseFee = map['CourseFee'];
    CourseName = map['CourseName'];
    duration = map['duration'];
    image = map['image'];
    instructor = map['instructor'];

    // userNumber: map['userNumber'],
  }

  // sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'cid': cid,
      'CourseFee': CourseFee,
      'CourseName': CourseName,
      'duration': duration,
      'image': image,
      'instructor': instructor,

      // 'userNumber': userNumber
    };
  }

    
}
