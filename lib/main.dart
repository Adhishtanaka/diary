import 'package:diary/ui/home.dart';
import 'package:diary/ui/login.dart';
import 'package:diary/ui/updateDiary.dart';
import 'package:flutter/material.dart';
import 'package:diary/ui/addDiary.dart';
import 'package:diary/ui/register.dart';
import 'package:diary/utils/auth_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: FutureBuilder<int?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData && snapshot.data != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => const HomePage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/addDiary': (BuildContext context) => const AddDiaryPage(),
        '/updateDiary': (BuildContext context) => const UpdateDiaryPage(),

      },
    );
  }
}
