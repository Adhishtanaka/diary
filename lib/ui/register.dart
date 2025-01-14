import 'package:flutter/material.dart';
import 'package:diary/utils/db_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('diary register'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}