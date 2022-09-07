import 'package:cloud_firestore/cloud_firestore.dart';

class Sacco {
  String? saccoId;
  String? saccoName;
  String? type;
  String? termconditions;
  List<dynamic>? members;
  String? role;
  String? purpose;
  String? aboutSacco;
  Timestamp? createdDate;
  Timestamp? updatedDate;

  Sacco();

  Sacco.fromMap(Map<String, dynamic> sacco) {
    saccoId = sacco["saccoId"];
    saccoName = sacco["saccoName"];
    type = sacco["type"];
    termconditions = sacco["termconditions"];
    members = sacco["members"];
    role = sacco["role"];
    purpose = sacco["purpose"];
    createdDate = sacco["createdDate"];
    updatedDate = sacco["updatedDate"];
    aboutSacco = sacco["aboutSacco"];
  }
  Map<String, dynamic> toMap() {
    return {
      "saccoId": saccoId,
      "saccoName": saccoName,
      "type": type,
      "termconditions": termconditions,
      "members": members,
      "role": role,
      "purpose": purpose,
      "aboutSacco": aboutSacco,
      "createdDate": createdDate,
      "updatedDate": updatedDate,
    };
  }
}
