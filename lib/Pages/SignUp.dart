import 'package:flutter/material.dart';
import 'package:fmms_mobile_app/models/user.dart';
import 'package:fmms_mobile_app/Pages/Login.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:fmms_mobile_app/Services/mongodb.dart' ;

 

class SignupPage extends StatefulWidget {
  final PageController controller;
  const SignupPage({Key? key, required this.controller}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  String? _roleValue;
  String? _departmentValue;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _regNoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  void _updateRole() {
    String regNo = _regNoController.text;
    setState(() {
      if (regNo.startsWith('EG')) {
        _roleValue = 'Student';
      } else if (regNo.startsWith('AC')) {
        _roleValue = 'Academic Staff';
      } else if (regNo.startsWith('AD')) {
        _roleValue = 'Admin';
      } else if (regNo.startsWith('MD')) {
        _roleValue = 'Maintenance Division';
      } else {
        _roleValue = null; // Clear role if not matched
      }
    });
  }

  Future<void> _signUp(
    String fullName,
    String email,
    String regNo,
    String password,
    String confirmPassword,
    String contactNumber,
    String role,
    String department,
  ) async {
    if (password != confirmPassword) {
      // Show error if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    var _id = mongo.ObjectId();

    final status = role == 'Maintenance Division' ? 'inactive' : 'active';

    User newUser = User(
      id: _id,
      fullName: fullName,
      email: email,
      regNo: regNo,
      password: password,
      confirmPassword: confirmPassword,
      contactNumber: contactNumber,
      role: role,
      department: department,
      status: status,
    );

     void _clearAll() {
    _fullNameController.clear();
    _emailController.clear();
    _regNoController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _contactNumberController.clear();
  }

    String result = await MongoDatabase.insert(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    if (result != null && result is String) {
      // If data insertion is successful, navigate to LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  controller: widget.controller,
                )),
      );
    } else {
      // Handle insertion failure here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add data to the database.'),
        ),
      );
    }

    _clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 24, 8, 163),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 0),
              Container(
                width: 1000,
                height: 100,
                child: Image.asset("assets/draw2.jpg"),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 225, 237, 241),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 234, 225, 232),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _regNoController,
                onChanged: (value) => _updateRole(), // Update role on regNo change
                decoration: InputDecoration(
                  labelText: 'Registration No.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 225, 237, 241),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                enabled: false, // Disable user input
                controller: TextEditingController(text: _roleValue ?? ''),
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 234, 225, 232),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _departmentValue,
                onChanged: (value) {
                  setState(() {
                    _departmentValue = value;
                  });
                },
                items: [
                  'Electrical and Information Department',
                  'Civil and Environmental Department',
                  'Mechanical and Manufacturing Department',
                  'Marine and Naval Architecture',
                  'Interdisciplinary Studies',
                  'Maintenance Division',
                  'Admin Sector'
                ]
                    .map<DropdownMenuItem<String>>(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Department',
                  hintText: 'Select Department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 225, 237, 241),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contactNumberController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 234, 225, 232),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 225, 237, 241),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 234, 225, 232),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                obscureText: true,
              ),
              SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                width: 20,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_roleValue != null && _departmentValue != null) {
                      _signUp(
                        _fullNameController.text,
                        _emailController.text,
                        _regNoController.text,
                        _passwordController.text,
                        _confirmPasswordController.text,
                        _contactNumberController.text,
                        _roleValue!,
                        _departmentValue!,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please complete all fields')),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 237, 130, 7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
