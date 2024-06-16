import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'maintenance_requests.dart'; // Import your custom widgets
// import 'student_ongoing_maintenance.dart'; // Import your custom widgets
// import 'student_notifications.dart'; // Import your custom widgets

class AcademicStaffPage extends StatefulWidget {
   final String id;

  AcademicStaffPage({required this.id});

  @override
  _AcademicStaffPageState createState() => _AcademicStaffPageState();
}

class _AcademicStaffPageState extends State<AcademicStaffPage> {
  String activeTab = 'maintenanceRequests';

  void setActiveTab(String tab) {
    setState(() {
      activeTab = tab;
    });
  }

  void toggleSidebar() {
    // Implement your sidebar toggle logic here
    // Note: Flutter usually handles navigation differently than web, using Drawer or BottomNavigationBar
    // depending on the design pattern.
  }

  Future<void> handleLogout() async {
    // Implement your logout logic if needed
    // Example:
    // try {
    //   // Perform logout operation
    //   // Navigate to login screen
    // } catch (e) {
    //   print('Error during logout: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Navigation Bar (Top App Bar)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.lightBlue, // Adjust color as per your design
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggleSidebar,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: handleLogout,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Tab Navigation
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTab('Maintenance Requests', 'maintenanceRequests'),
                  buildTab('Ongoing Maintenance', 'ongoingMaintenance'),
                  buildTab('Notifications', 'notifications'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IndexedStack(
                  index: activeTab == 'maintenanceRequests'
                      ? 0
                      : activeTab == 'ongoingMaintenance'
                          ? 1
                          : 2,
                  // children: [
                  //   MaintenanceRequests(userId: widget.userId),
                  //   StudentOngoingMaintenance(userId: widget.userId),
                  //   StudentNotifications(userId: widget.userId),
                  // ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTab(String title, String tab) {
    return InkWell(
      onTap: () => setActiveTab(tab),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: activeTab == tab ? Colors.lightBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: activeTab == tab ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

