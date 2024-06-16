import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AdminPage extends StatefulWidget {
final String id;

  AdminPage({Key? key, required this.id}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<dynamic> requests = [];
  String? error;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/users'));
      if (response.statusCode == 200) {
        final allUsers = jsonDecode(response.body)['existingUsers'];
        final inactiveRequests = allUsers.where((user) => user['status'] == 'inactive').toList();
        setState(() {
          requests = inactiveRequests;
        });
      } else {
        setState(() {
          error = 'Error fetching requests';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching requests';
      });
      print('Error fetching requests: $e');
    }
  }

  Future<void> handleApprove(String userId) async {
    try {
      final response = await http.put(Uri.parse('http://localhost:8000/user/approve/$userId'));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Approve successful!');
        fetchRequests();
      } else {
        setState(() {
          error = 'Error approving request';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error approving request';
      });
      print('Error approving request: $e');
    }
  }

  Future<void> handleReject(String userId) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:8000/user/delete/$userId'));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Reject successful!');
        fetchRequests();
      } else {
        setState(() {
          error = 'Error rejecting request';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error rejecting request';
      });
      print('Error rejecting request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: error != null
          ? Center(child: Text(error!))
          : ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${request['fullName']}', style: TextStyle(fontSize: 16)),
                        Text('Email: ${request['email']}', style: TextStyle(fontSize: 16)),
                        Text('UserName: ${request['regNo']}', style: TextStyle(fontSize: 16)),
                        Text('Contact Number: ${request['contactNumber']}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                        Text('Status: ${request['status']}', style: TextStyle(fontSize: 16)),
                        if (request['status'] == 'inactive') ...[
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => handleApprove(request['_id']),
                                child: Text('Approve'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => handleReject(request['_id']),
                                child: Text('Reject'),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
