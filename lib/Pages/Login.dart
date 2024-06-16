import 'package:flutter/material.dart';
import 'package:fmms_mobile_app/Pages/SignUp.dart';
import 'package:fmms_mobile_app/Pages/student_page.dart';
import 'package:fmms_mobile_app/Pages/admin_page.dart';
import 'package:fmms_mobile_app/Pages/acadamic_staff_page.dart';
import 'package:fmms_mobile_app/Pages/maintenance_division_page.dart';
import 'package:fmms_mobile_app/Services/mongodb.dart'; // Import MongoDB service
import 'package:fmms_mobile_app/models/user.dart';

class LoginPage extends StatefulWidget {
  final PageController controller;

  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String regNo = _usernameController.text;
      String password = _passwordController.text;

      // Fetch the user from the database
      User? user = await MongoDatabase.login(regNo, password);

      if (user != null && user.status == 'active') {
        handleLogin(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
      } else if (user != null && user.status != 'active') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your account is inactive. Please contact an administrator.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid registration number or password')),
        );
      }
    }
  }

  void handleLogin(User user) {
    switch (user.role) {
      case 'Student':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentPage(id: user.id.toHexString())),
        );
        break;
      case 'Admin':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage(id: user.id.toHexString())),
        );
        break;
      case 'Academic Staff':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AcademicStaffPage(id: user.id.toHexString())),
        );
        break;
      case 'Maintenance Division':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MaintenanceDivisionPage(id: user.id.toHexString())),
        );
        break;
      default:
        print('Unknown role: ${user.role}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 35,
                color: Color.fromARGB(255, 24, 8, 163),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // Adjusted height for spacing
            Container(
              width: 300,
              height: 200,
              child: Image.asset("assets/draw2.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Registration Number',
                        hintText: 'Enter Registration Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter registration number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Adjusted height for spacing
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 231, 133, 48),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Adjusted padding
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(controller: widget.controller),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF003580),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        // Handle forget password logic
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Color(0xFF003580),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
