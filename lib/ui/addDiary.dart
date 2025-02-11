import 'package:flutter/material.dart';
import 'package:diary/utils/auth_helper.dart';
import 'package:diary/utils/diary_helper.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage({super.key});

  @override
  AddDiaryPageState createState() => AddDiaryPageState();
}

class AddDiaryPageState extends State<AddDiaryPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> saveDiary() async {
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
      await addDiaryEntry(
        userId,
        titleController.text,
        descriptionController.text,
        DateTime.now(),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Entry", style: TextStyle(fontSize: 18)),
      ),
      body: Container(
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
                  hintText: "Start writing...",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveDiary,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black87,
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.save,size: 22,),
      ),
    );
  }
}
