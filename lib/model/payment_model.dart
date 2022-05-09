class PaymentModel {
  late String uid;
  late String firstname;
 late String lastname;
 late String email;
 late String phone;
 late String amount;

  PaymentModel(
    this.uid,
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.amount,
  );
  PaymentModel.fromMap(Map map) {
    uid = map['uid'];
    firstname = map['firstname'];
    lastname = map['lastname'];
    phone = map['phone'];
    email = map['email'];
    amount = map['amount'];
  }
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'otp': amount,
    };
  }
}
