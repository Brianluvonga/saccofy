import 'package:cloud_firestore/cloud_firestore.dart';

class Sacco {
  String? saccoId;
  String? saccoName;
  String? type;
  String? saccoLink;
  String? termconditions;
  List members = [];
  String? role;
  String? purpose;
  String? period;
  String? aboutSacco;
  Timestamp? createdDate;
  Timestamp? updatedDate;

  Sacco();

  Sacco.fromMap(Map<String, dynamic> sacco) {
    saccoId = sacco["saccoId"];
    saccoName = sacco["saccoName"];
    type = sacco["type"];
    saccoLink = sacco["saccoLink"];
    termconditions = sacco["termconditions"];
    members = sacco["members"];
    role = sacco["role"];
    purpose = sacco["purpose"];
    period = sacco["period"];
    createdDate = sacco["createdDate"];
    updatedDate = sacco["updatedDate"];
    aboutSacco = sacco["aboutSacco"];
  }
  Map<String, dynamic> toMap() {
    return {
      "saccoId": saccoId,
      "saccoName": saccoName,
      "type": type,
      "saccoLink": saccoLink,
      "termconditions": termconditions,
      "members": members,
      "role": role,
      "purpose": purpose,
      "period": period,
      "aboutSacco": aboutSacco,
      "createdDate": createdDate,
      "updatedDate": updatedDate,
    };
  }
}
