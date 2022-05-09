import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class CourseController {
  // FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // CollectionReference users =
  // FirebaseFirestore.instance.collection('users');
  // final _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getProduceID() async {
    var data = await FirebaseFirestore.instance
        .collection('Section').get();

    // var data = await FirebaseFirestore.instance
    //     .collection('course').where('type', isEqualTo: '1')
    //     // .doc("DwrBjyNabsR1u4mB2OeP")
    //     // .collection('Section').where('course_id', isEqualTo: 'DwrBjyNabsR1u4mB2OeP')
    //     .get();
    var productId = data.docs;
    Logger().d(">>>>>>>>>>>>>>>>>>>>>>>>> : " + productId.toString());
    return productId;
  }
}
