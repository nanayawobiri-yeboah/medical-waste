import 'package:flutter/material.dart';
import 'package:medical_waste/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Waste Management',
      theme: ThemeData(
        primaryColor: Colors.blue, 
      ),
      home: const OnboardingPage(), 
    );
  }
}


