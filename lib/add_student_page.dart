import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddStudentPage extends StatelessWidget {
  final id = TextEditingController();
  final name = TextEditingController();
  final dept = TextEditingController();
  final level = TextEditingController();

  Future addStudent(BuildContext context) async {
    final res = await http.post(
      Uri.parse("http://my-attendance-app.atwebpages.com/add_student.php"),
      body: {
        "student_id": id.text,
        "name": name.text,
        "department": dept.text,
        "level": level.text,
      },
    );

    if (res.body.contains("success")) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: id, decoration: const InputDecoration(labelText: "Student ID")),
            TextField(controller: name, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: dept, decoration: const InputDecoration(labelText: "Department")),
            TextField(controller: level, decoration: const InputDecoration(labelText: "Level")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => addStudent(context), child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
