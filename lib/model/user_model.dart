import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  UserModel(
      {this.uid, this.firstName, this.lastName, this.email, this.phoneNumber});

  // recieving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        phoneNumber: map['phoneNumber']);
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber
    };
  }
}
