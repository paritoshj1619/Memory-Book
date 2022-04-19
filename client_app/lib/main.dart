import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client_app/screens/display_photo.dart';
import 'package:client_app/screens/home.dart';
import 'package:client_app/screens/login.dart';
import 'package:client_app/screens/register.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/display-photo': (context) => const DisplayPhoto(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("secret_code") ? const HomeScreen() : const LoginScreen();
  }
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    isLoggedIn().then((screen) {
      Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            color: Colors.amber,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: const Text(
            "Memories",
            style: TextStyle(
              fontSize: 38.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
