   import 'package:firebase_core/firebase_core.dart';
import 'package:fmms_mobile_app/Pages/student_page.dart';
   import 'package:fmms_mobile_app/Services/mongodb.dart';
  //import 'firebase_options.dart';
 
   import 'package:flutter/material.dart';
   import 'package:fmms_mobile_app/Pages/Login.dart';
   import 'package:fmms_mobile_app/Pages/SignUp.dart';
// import 'package:fmms/AppBar/appbar.dart';
import 'package:fmms_mobile_app/Pages/Welcome.dart';
 
import 'dart:io';


 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect(); 
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF003580),
      ),
      home: WelcomeScreen(), //WelcomeScreen(),
    );
  }
}

class AppPages extends StatefulWidget {
  const AppPages({Key? key}) : super(key: key);

  @override
  _AppPagesState createState() => _AppPagesState();
}

class _AppPagesState extends State<AppPages> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: 3, // Number of pages
        itemBuilder: (context, index) {
          // Return the corresponding page based on the index
          switch (index) {
             case 0:
               return LoginPage(controller: _pageController);
             case 1:
               return SignupPage(controller: _pageController);
            //  case 2:
            //    return StudentPage(controller: _pageController);
            // default:
            //   throw Exception("Invalid page index");
          }
        },
      ),
    );
  }
}
