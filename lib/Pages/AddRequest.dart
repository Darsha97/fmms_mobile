import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fmms_mobile_app/models/request.dart';
import 'package:fmms_mobile_app/Services/mongodb.dart';

class RequestPage extends StatefulWidget {
  final String userId;
  final ScrollController controller;

  RequestPage({required this.userId, required this.controller});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController placeController = TextEditingController();
  TextEditingController issueTypeController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController submittedByController = TextEditingController();
  File? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedPlace;
  List<String> _place = [
    'Electrical and Information Department',
    'Civil and Environmental Department',
    'Mechanical and Manufacturing Department',
    'Marine and Naval Architecture',
    'Interdisciplinary Studies',
    'Maintenance Division',
    'Admin Sector',
    'Canteen',
    'Hostel D',
    'Hostel C',
    'Library',
    'LT1',
    'LT2',
    'Other'
  ];

  String? _selectedIssue;
  List<String> _issueType = [
    'Electrical',
    'Plumbing',
    'HVAC (Heating, Ventilation, and Air Conditioning)',
    //'Appliance',
    //'Structural',
    //'Security and Safety',
    //'IT and Technology',
    //'Grounds Maintenance',
    'Other'
  ];

  String? _selectedPriority;
  List<String> _priority = ['High', 'Medium', 'Low'];

  // Define the getImage method to pick an image from gallery
  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 5,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 130, // Adjust the height according to your needs
              child: Image.asset("assets/draw2.jpg", fit: BoxFit.cover), // Ensure the image covers the area
            ),
            SizedBox(height: 0),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Container(
                  margin: EdgeInsets.only(top: 118),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Set background color of the frame
                    borderRadius: BorderRadius.circular(10), // Set border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Set shadow color
                        spreadRadius: 5, // Set spread radius
                        blurRadius: 7, // Set blur radius
                        offset: Offset(0, 3), // Set shadow offset
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical:2, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 3),
                      Text(
                        'Add Your Request',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(labelText: 'Place'),
                                value: _selectedPlace,
                                items: _place.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedPlace = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a place';
                                  }
                                  return null;
                                },
                                 padding: EdgeInsets.symmetric(vertical:1),
                              ),
                              if (_selectedPlace == 'Other')
                                TextFormField(
                                  controller: placeController,
                                  decoration: InputDecoration(labelText: 'Enter department or place'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a department or place';
                                    }
                                    return null;
                                  },
                                ),
                              SizedBox(height: 1),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(labelText: 'Issue Type'),
                                value: _selectedIssue,
                                items: _issueType.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedIssue = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select an issue type';
                                  }
                                  return null;
                                },
                               // padding: EdgeInsets.symmetric(vertical:1),
                              ),
                              if (_selectedIssue == 'Other')
                                TextFormField(
                                  controller: issueTypeController,
                                  decoration: InputDecoration(labelText: 'Enter issue type'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an issue type';
                                    }
                                    return null;
                                  },
                                  
                                ),
                              SizedBox(height: 1),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(labelText: 'Priority'),
                                value: _selectedPriority,
                                items: _priority.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedPriority = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a priority';
                                  }
                                  return null;
                                },
                                padding: EdgeInsets.symmetric(vertical:1),
                                
                                
                              
                              ),
                              SizedBox(height: 1),
                              TextFormField(
                                controller: descriptionController,
                                decoration: InputDecoration(labelText: 'Description'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3),
                              TextFormField(
                                controller: departmentController,
                                decoration: InputDecoration(labelText: 'Department'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the department';
                                  }
                                  return null;
                                },
                                
                              ),
                              SizedBox(height: 1),
                              TextFormField(
                                controller: submittedByController,
                                decoration: InputDecoration(labelText: 'Submitted By'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the name of the person submitting the request';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3),
                              InkWell(
                                onTap: getImage,
                                child: Row(
                                  children: [
                                    Icon(Icons.attach_file, color: Colors.blue),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        "Attach Image",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3),
                              if (_image != null)
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.file(_image!),
                                ),
                              SizedBox(height: 3),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Create a MaintenanceRequest object with form data
                                    MaintenanceRequest request = MaintenanceRequest(
                                      place: _selectedPlace ?? 'N/A',
                                      issueType: _selectedIssue ?? 'N/A',
                                      priority: _selectedPriority ?? 'N/A',
                                      description: descriptionController.text,
                                      department: departmentController.text,
                                      submittedBy: submittedByController.text,
                                      image: _image?.path ?? '', // Ensure a default value is provided
                                    );
                              
                                    // Add the request to MongoDB
                                    String message = await MongoDatabase.insertMaintenanceRequest(request);
                              
                                    Fluttertoast.showToast(
                                      msg: message,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                              
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Add Request",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(0xFFfeba02),
                                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
