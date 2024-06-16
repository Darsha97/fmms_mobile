 
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fmms_mobile_app/main.dart';
import 'package:fmms_mobile_app/Pages/Login.dart';
import 'package:fmms_mobile_app/Pages/SignUp.dart';

 
class WelcomeScreen extends StatelessWidget {
  final Duration duration = const Duration(milliseconds: 800);

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Container(
        margin: const EdgeInsets.all(8),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeIn(
              duration: duration,
              delay: const Duration(milliseconds: 2000),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 5,
                  right: 5,
                ),
                width: size.width,
                height: size.height / 2,
                child:Image.asset("assets/welcome.png"),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1600),
              child: const Text(
                "Welcome!",
                style: TextStyle(
                  color: Color(0xFF003580),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 1000),
              child: const Text(
                "Effortless Faculty Management – Streamlining Maintenance Tasks.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Expanded(child: Container()),
            FadeInUp(
              duration: duration,
              delay: const Duration(milliseconds: 600),
              child: SButton(
                size: size,
                borderColor: Colors.grey,
                color: Color(0xFF003580),
                icon: Icons.play_arrow,
                text: "Start Now",
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppPages()),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class SButton extends StatelessWidget {
  const SButton({
    Key? key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.icon,
    required this.text,
    required this.textStyle,
    required this.onTap, // New parameter
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;
  final IconData icon;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onTap; // New parameter

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the onTap callback
      child: Container(
        width: size.width / 1.2,
        height: size.height / 15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
