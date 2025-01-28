import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackwave/pages/Admin/AdminDashboard.dart';
import 'package:hackwave/pages/Admin/AdminComplaints.dart';
import 'package:hackwave/pages/Admin/Adminfeedback.dart';
import 'package:hackwave/widgets/Bottom.dart';
import 'package:http/http.dart' as http;

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Future<void> fetchData() async {
    final url = Uri.parse('http://10.0.2.2:5000/api/admin/predictions'); // Replace with your API URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);
        print('Data fetched successfully: $data');

        // Navigate to the AdminDashboardPage with fetched data
        if (context.mounted) { // Ensure context is still valid
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminDashboardPage(data: List<Map<String, dynamic>>.from(data)),
            ),
          );
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        _showErrorDialog('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('An error occurred while fetching data: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: const Color(0xFF4CAF50),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30.0),
          )
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Admin Home',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAFBF1),
      body: Column(
        children: [
          const SizedBox(height: 30),
          // Containers Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Dashboard Container
                  GestureDetector(
                    onTap: () {
                     fetchData();
                    },
                    child: buildCard('Dashboard', Icons.dashboard),
                  ),
                  const SizedBox(height: 20),

                  // Complaints Container
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComplaintsPage(),
                          ));
                    },
                    child: buildCard('Complaints', Icons.report),
                  ),
                  const SizedBox(height: 20),

                  // Feedback Container
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackPage()));
                    },
                    child: buildCard('Feedback', Icons.feedback),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Bottom(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  // Method to Build a Card
  Widget buildCard(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF4CAF50),
                size: 30,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }
}
