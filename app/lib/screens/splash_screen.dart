import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;

  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 500 milliseconds before navigating to the next screen
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => widget.nextScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the app icon from the app's main directory
    final appIcon = Image.asset(
      'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png', // Adjust path as needed
      width: 100,
      height: 100,
    );

    return Scaffold(
      body: Center(
        child: appIcon,
      ),
    );
  }
}