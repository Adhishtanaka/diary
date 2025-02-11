import 'package:flutter/material.dart';
import 'package:diary/utils/auth_helper.dart';
import 'package:diary/utils/diary_helper.dart';

class UpdateDiaryPage extends StatefulWidget {
  const UpdateDiaryPage({super.key});

  @override
  UpdateDiaryPageState createState() => UpdateDiaryPageState();
}

class UpdateDiaryPageState extends State<UpdateDiaryPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    loadData();
  }

  void loadData() async {
    int? userId = await getUserData();
    if (userId != null) {
      Map<String, dynamic>? diary = await getUserDiary(userId, DateTime.now());
      setState(() {
        titleController.text = diary?['title'] ?? "";
        descriptionController.text = diary?['description'] ?? "";

      });
    }
  }


  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> updateDiary() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title and description cannot be empty"),
        ),
      );
      return;
    }
    int? userId = await getUserData();
    if (userId != null) {
      await updateDiaryEntry(
        userId,
        titleController.text,
        descriptionController.text,
        DateTime.now()
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Entry", style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 1,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 5),
              TextField(
                controller: descriptionController,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 18,
                ),
                decoration: const InputDecoration(
                  hintText: "Update your entry...",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateDiary,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black87,
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.save, size: 22),
      ),
    );
  }
}
