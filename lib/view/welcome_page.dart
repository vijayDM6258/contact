import 'package:contact/main.dart';
import 'package:contact/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Welcome to R&W",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                )),
            ElevatedButton(
                onPressed: () {
                  preferences.setBool("continue", true);
                  Navigator.pushNamed(context, PageName.homePage);
                },
                child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}
