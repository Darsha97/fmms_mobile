import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'all_requests.dart'; // Import your custom widgets
// import 'ongoing_maintenance.dart'; // Import your custom widgets
// import 'completed_maintenance.dart'; // Import your custom widgets

class MaintenanceDivisionPage extends StatefulWidget {
   final String id;

  MaintenanceDivisionPage({Key? key, required this.id}) : super(key: key);
  
  @override
  _MaintenanceDivisionPageState createState() => _MaintenanceDivisionPageState();
}

class _MaintenanceDivisionPageState extends State<MaintenanceDivisionPage> {
  String activeTab = 'allmaintenanceRequests';

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
                ],
              ),
            ),

            // Tab Navigation
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTab('Pending Maintenance Requests', 'allmaintenanceRequests'),
                  buildTab('Ongoing Maintenance', 'ongoingMaintenance'),
                  buildTab('Completed Maintenance', 'completedMaintenance'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IndexedStack(
                  index: activeTab == 'allmaintenanceRequests'
                      ? 0
                      : activeTab == 'ongoingMaintenance'
                          ? 1
                          : 2,
                  // children: [
                  //   AllRequests(),
                  //   OngoingMaintenance(),
                  //   CompletedMaintenance(),
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

