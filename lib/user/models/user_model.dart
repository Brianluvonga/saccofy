import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? profilePic;
  String? email;
  String? idno;
  String? yob;
  String? gender;
  List saccoId = [];
  String? phonenumber;
  String? password;
  Timestamp? updatedAt;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> user) {
    id = user['id'];
    firstname = user['firstname'];
    lastname = user['lastname'];
    profilePic = user['profilePic'];
    email = user['email'];
    idno = user['idno'];
    yob = user['yob'];
    gender = user['gender'];
    saccoId = user['saccoId'];
    phonenumber = user['phonenumber'];
    password = user['password'];
    updatedAt = user['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'profilePic': profilePic,
      'email': email,
      'idno': idno,
      'yob': yob,
      'gender': gender,
      'saccoId': saccoId,
      'phonenumber': phonenumber,
      'password': password,
      'updatedAt': updatedAt,
    };
  }
}
