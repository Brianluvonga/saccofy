import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:saccofy/user/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _user = [];

  UnmodifiableListView<UserModel> get users => UnmodifiableListView(_user);

  String? userAPICALL = 'http://10.0.2.2:8000/user/user';
  void addUser(UserModel user) async {
    final response = await http.post(
      Uri.parse(userAPICALL!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    if (response.statusCode == 201) {
      user.email = json.decode(response.body)['email'];
      _user.add(user);

      notifyListeners();
    }
  }

  getUsers() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/user/users"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _user = data.map<UserModel>((json) => UserModel.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
