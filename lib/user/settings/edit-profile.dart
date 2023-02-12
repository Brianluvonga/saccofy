// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File? _profileImage;
  String? username, email, phone, gender;

  final picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _profileImage = File(pickedFile!.path);
    });
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform API call to save changes
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
          content: Text("Profile Successfully Updated", style: TextStyle()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: _submit,
            child: Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 35,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _profileImage != null
                        ? FileImage(_profileImage!, scale: 2)
                        : const NetworkImage(
                            "https://via.placeholder.com/150",
                          ) as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
                child: GestureDetector(
                  onTap: () => pickImage(ImageSource.gallery),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const NetworkImage(
                                    'https://via.placeholder.com/150')
                                as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (input) => input!.trim().length < 3
                          ? 'Please enter a valid username'
                          : null,
                      onSaved: (input) => username = input,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (input) => !input!.contains('@')
                          ? 'Please enter a valid email'
                          : null,
                      onSaved: (input) => email = input,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (input) => input!.trim().length < 10
                          ? 'Please enter a valid phone number'
                          : null,
                      onSaved: (input) => phone = input,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Gender'),
                      value: gender,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Male'),
                          value: 'male',
                        ),
                        DropdownMenuItem(
                          child: Text('Female'),
                          value: 'female',
                        ),
                        DropdownMenuItem(
                          child: Text('Other'),
                          value: 'other',
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          gender = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select a gender' : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
