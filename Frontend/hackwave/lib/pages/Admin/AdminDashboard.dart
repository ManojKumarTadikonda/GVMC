import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AdminDashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  AdminDashboardPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort data in ascending order by percentage
    final sortedData = List<Map<String, dynamic>>.from(data)
      ..sort((a, b) => b['currentPercentWaste'].compareTo(a['currentPercentWaste']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      backgroundColor: const Color(0xFFEAFBF1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 containers per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0, // Adjust aspect ratio to reduce height
          ),
          itemCount: sortedData.length,
          itemBuilder: (context, index) {
            final item = sortedData[index];
            final percentage = item['currentPercentWaste'] as int;

            // Determine color based on percentage
            Color progressColor;
            if (percentage > 75) {
              progressColor = Colors.red;
            } else if (percentage > 50) {
              progressColor = Colors.orange;
            } else {
              progressColor = Colors.green;
            }

            return Container(
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    item['loc_name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 8,
                    percent: percentage / 100,
                    center: Text(
                      "$percentage%",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    progressColor: progressColor,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Text(
                    "Last Reported: ${item['lastReportedDate'].split('T')[0]}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Overflow: ${item['nextOverflowDate'].split('T')[0]}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
