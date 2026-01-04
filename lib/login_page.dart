import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'student_list_page.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      final res = await http.post(
        Uri.parse("http://my-attendance-app.atwebpages.com/login.php"),
        body: {
          "email": email.text.trim(),
          "password": password.text.trim(),
        },
      );


      final data = json.decode(res.body);

      if (data['status'] == "success") {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => StudentListPage()),
        );
      } else {
    
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connection Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => login(context), child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}