class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? idno;
  String? yob;
  String? gender;
  String? saccoId;
  String? phonenumber;
  String? password;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> user) {
    id = user['id'];
    firstname = user['firstname'];
    lastname = user['lastname'];
    email = user['email'];
    idno = user['idno'];
    yob = user['yob'];
    gender = user['gender'];
    saccoId = user['saccoId'];
    phonenumber = user['phonenumber'];
    password = user['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'idno': idno,
      'yob': yob,
      'gender': gender,
      'saccoId': saccoId,
      'phonenumber': phonenumber,
      'password': password,
    };
  }
}
