import 'package:flutter/material.dart';
import 'package:diary/utils/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late String userName;
  final now = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('diary'),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Hello , $userName !!"),
              Text(now),
            ],
          ),
        ));
  }
}
