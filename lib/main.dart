import 'package:flutter/material.dart';
import 'package:registration_app/create_user_profile_screen.dart';
import 'package:registration_app/otp_screen.dart';

import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmiCane App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      // home: OTPScreen(mobile: '8605750039', verificationId: '123'),
      // home: CreateUserProfileScreen(mobile: '8605750039'),
    );
  }
}