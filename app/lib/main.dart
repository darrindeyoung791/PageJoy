import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/index.dart';
import 'services/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageJoy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Lato', // Default font family
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/article': (context) => const ArticleScreen(),
        '/magazine': (context) => const MagazineScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/subscription': (context) => const SubscriptionScreen(),
      },
    );
  }
}
