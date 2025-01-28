import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackwave/pages/login.dart';
import 'package:hackwave/widgets/Bottom.dart';
import 'package:http/http.dart' as http;

class Supervisor extends StatefulWidget {
  final String name;
  const Supervisor({super.key, required this.name});
  @override
  State<Supervisor> createState() => _SupervisorState();
}

class _SupervisorState extends State<Supervisor> {
  String selectedRole = "MVP Colony"; // Default dropdown selection
  bool isLoading = false;
  final TextEditingController usernameController = TextEditingController();

  Future<void> _SendSignUpApi(
    String locName,
    String lastReportedDate,
    int currentPercentWaste,
  ) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('http://10.0.2.2:5000/api/supervisor/submit');
    final body = {
      "loc_name": locName,
      "lastReportedDate": lastReportedDate,
      "currentPercentWaste": currentPercentWaste,
    };
    print(body);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      print(response.body);
      if (response.statusCode == 201) {
        showSnackbar("Submitted Successfully", Colors.green);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => LoginPage(),
          ),
        );
      } else {
        showSnackbar("Error while submitting", Colors.red);
      }
    } catch (e) {
      showSnackbar(
        "An error occurred. Check your connection and try again.",
        Colors.red,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showSnackbar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static const Map<String, String> locations = {
    "MVP Colony": "2025-01-22",
    "Gajuwaka": "2025-01-23",
    "Dwaraka Nagar": "2025-01-21",
    "RK Beach": "2025-01-20",
    "Seethammadhara": "2025-01-19",
    "Kailasagiri": "2025-01-18",
    "Arilova": "2025-01-17",
    "Pendurthi": "2025-01-16",
    "Bheemunipatnam": "2025-01-15",
    "Anakapalle": "2025-01-14",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAFBF1),
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF4CAF50),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: GestureDetector(
                  onTap: () {
                    // Notifications action can be handled here
                  },
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
            title: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Supervisor',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Report daily waste percentage',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    labelStyle: const TextStyle(
                        color: Colors.green, fontSize: 16), // Label styling
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.green, // Border color
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        width: 2.0,
                      ),
                    ),
                  ),
                  dropdownColor:
                      Colors.lightGreen[100], // Background color for dropdown
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Colors.black), // Dropdown arrow icon
                  items: locations.keys
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: TextStyle(
                                color: Colors.green[800], // Text color
                                fontSize: 16, // Font size
                                fontWeight: FontWeight.bold, // Bold text
                              ),
                            ),
                          ))
                      .toList(),
                  style: TextStyle(
                    color: Colors.green[900], // Text style of the selected item
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Waste Percentage (1-100)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final locName = selectedRole;
                          final lastReportedDate =
                              locations[selectedRole]!; // Date from dropdown
                          final currentPercentWaste =
                              int.tryParse(usernameController.text) ?? 0;

                          if (currentPercentWaste < 1 ||
                              currentPercentWaste > 100) {
                            showSnackbar(
                                "Enter a valid percentage (1-100)", Colors.red);
                            return;
                          }

                          _SendSignUpApi(
                              locName, lastReportedDate, currentPercentWaste);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    isLoading ? 'Submitting...' : 'Submit',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
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
}
