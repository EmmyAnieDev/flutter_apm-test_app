// User Model
import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final List<String> hobbies;

  User({
    required this.name,
    required this.age,
    required this.hobbies,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      age: json['age'],
      hobbies: List<String>.from(json['hobbies']),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // This will cause runtime error - storing user data as String instead of User model
  String userData =
      '{"name": "John", "age": 25, "hobbies": ["reading", "gaming"]}';

  void _triggerError() {
    // This will cause runtime error - trying to use String as User model
    User user = userData as User; // Runtime Error: String is not a User

    // Or alternatively
    setState(() {
      // This will also cause runtime error - trying to treat the whole string as a List
      List<User> users =
          userData as List<User>; // Runtime Error: String is not a List
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _triggerError,
          child: Text('Trigger Type Error'),
        ),
      ),
    );
  }
}
