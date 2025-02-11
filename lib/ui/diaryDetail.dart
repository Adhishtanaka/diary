import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:diary/utils/auth_helper.dart';
import 'package:diary/utils/diary_helper.dart';


class DiaryDetail extends StatelessWidget {
  final Map<String, dynamic> diary;

  const DiaryDetail({super.key, required this.diary});

  Future deleteEntry(DateTime day) async {
    int? userId = await getUserData();
    if (userId != null) {
      await deleteDiaryEntry(userId, day);
    }
  }

  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('EEEE, MMMM d, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          formatDate(diary['date_time']),
          style: const TextStyle(fontSize: 16),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    diary['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                    const SizedBox(height: 15),
                  Container(
                    height: 1,
                    color: Colors.grey[400],
                  ),
                ],)
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  diary['description'],
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("Delete Entry"),
            content: const Text("Are you sure you want to delete this entry?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  deleteEntry(DateTime.now());
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        ),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.redAccent,
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.delete, size: 22),
      ),
    );
  }
}