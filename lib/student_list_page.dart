import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_student_page.dart';

class StudentListPage extends StatefulWidget {
  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      final res = await http.get(
        Uri.parse("http://my-attendance-app.atwebpages.com/get_students.php"),
      );

      if (res.statusCode == 200) {
        setState(() {
          students = json.decode(res.body);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching students: $e");
      setState(() {
        isLoading = false;
      });
      _showMessage("Could not load students. Check server headers.");
    }
  }

  Future<void> markAttendance(String studentId, String status) async {
    try {
      final res = await http.post(
        Uri.parse(
          "http://my-attendance-app.atwebpages.com/mark_attendance.php",
        ),
        body: {"student_id": studentId, "status": status},
      );

      if (res.body.contains("success")) {
        _showMessage("Marked $status for ID: $studentId", isError: false);
      } else {
        _showMessage("Server Error: ${res.body}");
      }
    } catch (e) {
      _showMessage("Connection Error: $e");
    }
  }

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin: Student List"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: "Add New Student",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddStudentPage()),
              ).then((_) {
                setState(() => isLoading = true);
                fetchStudents();
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : students.isEmpty
          ? const Center(child: Text("No students found."))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (_, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 3,
                child: ListTile(
                  title: Text(
                    students[i]['name'].toString().toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Student ID: ${students[i]['student_id']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => markAttendance(
                          students[i]['student_id'],
                          "Present",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "P",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),

                      ElevatedButton(
                        onPressed: () =>
                            markAttendance(students[i]['student_id'], "Absent"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          "A",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
