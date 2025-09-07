import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation
import 'package:provider/provider.dart';
import 'screens/index.dart';
import 'screens/font_test_screen.dart'; // Font test screen
import 'services/user_provider.dart';
import 'models/article.dart'; // Import Article model

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
        // Use NotoSansSC as default font for better Chinese support with increased weight
        fontFamily: 'NotoSansSC',
        textTheme: TextTheme(
          // Increase default font weight for better readability using fontVariations
          bodyLarge: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
          bodyMedium: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
          bodySmall: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
          titleLarge: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
          titleMedium: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
          titleSmall: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
        ),
        // Customize NavigationBar label style
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              fontWeight: FontWeight.w600,
              fontVariations: [FontVariation('wght', 600.0)],
            ),
          ),
        ),
        // Customize NavigationRail label style
        navigationRailTheme: const NavigationRailThemeData(
          selectedLabelTextStyle: TextStyle(
            fontFamily: 'NotoSansSC',
            fontWeight: FontWeight.w600,
            fontVariations: [FontVariation('wght', 600.0)],
            color: Colors.black, // 显式设置为黑色
          ),
          unselectedLabelTextStyle: TextStyle(
            fontFamily: 'NotoSansSC',
            fontWeight: FontWeight.w600,
            fontVariations: [FontVariation('wght', 600.0)],
            color: Colors.black, // 显式设置为黑色
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/magazine': (context) => const MagazineScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/subscription': (context) => const SubscriptionScreen(),
        '/font-test': (context) => const FontTestScreen(), // Font test screen
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/article') {
          final args = settings.arguments as Article;
          return MaterialPageRoute(
            builder: (context) => ArticleScreen(article: args),
          );
        }
        // Handle other dynamic routes or return null for 404
        return null;
      },
    );
  }
}
