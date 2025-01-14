import 'package:flutter/material.dart';
import 'package:diary/utils/db_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('diary Login'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
