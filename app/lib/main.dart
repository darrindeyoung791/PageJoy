import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation and SystemUiOverlayStyle
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart'; // For dynamic color support
import 'screens/index.dart';
import 'screens/font_test_screen.dart'; // Font test screen
import 'services/user_provider.dart';
import 'services/user_service.dart';
import 'models/article.dart'; // Import Article model
import 'services/api_service.dart'; // Import API service
import 'package:shared_preferences/shared_preferences.dart';
import 'services/article_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.init(); // Initialize API service
  
  // 检查用户登录状态并初始化UserProvider
  final userProvider = UserProvider();
  final currentUser = await UserService.getCurrentUser();
  if (currentUser != null) {
    userProvider.setUser(currentUser);
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => userProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _useDynamicColor = true; // 默认启用动态颜色

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load theme mode and dynamic color setting from shared preferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('themeMode') ?? 0;
    final useDynamicColor = prefs.getBool('useDynamicColor') ?? true;
    setState(() {
      _themeMode = ThemeMode.values[themeModeIndex];
      _useDynamicColor = useDynamicColor;
    });
  }

  // Update theme mode
  void _updateThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  // Update dynamic color setting
  void _updateDynamicColor(bool useDynamicColor) {
    setState(() {
      _useDynamicColor = useDynamicColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'PageJoy',
          themeMode: _themeMode,
          theme: _useDynamicColor && lightDynamic != null
              ? ThemeData(
                  colorScheme: lightDynamic,
                  useMaterial3: true,
                  // Use NotoSansSC as default font for better Chinese support with increased weight
                  fontFamily: 'NotoSansSC',
                  textTheme: const TextTheme(
                    // Increase default font weight for better readability using fontVariations
                    bodyLarge: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
                    bodyMedium: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
                    bodySmall: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
                    titleLarge: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
                    titleMedium: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
                    titleSmall: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
                  ),
                  // 设置AppBar主题以实现沉浸式状态栏
                  appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent, // 去除状态栏遮罩
                      statusBarIconBrightness: Brightness.dark, // 状态栏图标字体颜色
                      systemNavigationBarColor: lightDynamic.surface, // 底部导航栏颜色
                    ),
                  ),
                  // Customize NavigationBar label style
                  navigationBarTheme: const NavigationBarThemeData(
                    labelTextStyle: WidgetStatePropertyAll(
                      TextStyle(
                        fontWeight: FontWeight.w500,
                        fontVariations: [FontVariation('wght', 500.0)],
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  // Customize NavigationRail label style
                  navigationRailTheme: const NavigationRailThemeData(
                    selectedLabelTextStyle: TextStyle(
                      fontFamily: 'NotoSansSC',
                      fontWeight: FontWeight.w500,
                      fontVariations: [FontVariation('wght', 500.0)],
                      color: Colors.black, // 显式设置为黑色
                      fontSize: 12.0,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      fontFamily: 'NotoSansSC',
                      fontWeight: FontWeight.w500,
                      fontVariations: [FontVariation('wght', 500.0)],
                      color: Colors.black, // 显式设置为黑色
                      fontSize: 12.0,
                    ),
                  ),
                  // Customize button styles to increase font weight
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                    ),
                  ),
                )
              : _buildLightTheme(context),
          darkTheme: _useDynamicColor && darkDynamic != null
              ? ThemeData(
                  colorScheme: darkDynamic,
                  useMaterial3: true,
                  // Use NotoSansSC as default font for better Chinese support with increased weight
                  fontFamily: 'NotoSansSC',
                  textTheme: const TextTheme(
                    // Increase default font weight for better readability using fontVariations
                    bodyLarge: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
                    bodyMedium: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
                    bodySmall: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
                    titleLarge: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
                    titleMedium: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
                    titleSmall: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
                  ),
                  // 设置AppBar主题以实现沉浸式状态栏
                  appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent, // 去除状态栏遮罩
                      statusBarIconBrightness: Brightness.light, // 状态栏图标字体颜色
                      systemNavigationBarColor: darkDynamic.surface, // 底部导航栏颜色
                    ),
                  ),
                  // Customize NavigationBar label style
                  navigationBarTheme: const NavigationBarThemeData(
                    labelTextStyle: WidgetStatePropertyAll(
                      TextStyle(
                        fontWeight: FontWeight.w500,
                        fontVariations: [FontVariation('wght', 500.0)],
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  // Customize NavigationRail label style
                  navigationRailTheme: const NavigationRailThemeData(
                    selectedLabelTextStyle: TextStyle(
                      fontFamily: 'NotoSansSC',
                      fontWeight: FontWeight.w500,
                      fontVariations: [FontVariation('wght', 500.0)],
                      color: Colors.white, // 显式设置为白色
                      fontSize: 12.0,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      fontFamily: 'NotoSansSC',
                      fontWeight: FontWeight.w500,
                      fontVariations: [FontVariation('wght', 500.0)],
                      color: Colors.white, // 显式设置为白色
                      fontSize: 12.0,
                    ),
                  ),
                  // Customize button styles to increase font weight
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                    ),
                  ),
                )
              : _buildDarkTheme(context),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/magazine': (context) => const MagazineScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/subscription': (context) => const SubscriptionScreen(),
            '/settings': (context) => SettingsScreen(
              updateThemeMode: _updateThemeMode,
              updateDynamicColor: _updateDynamicColor,
            ),
            '/font-test': (context) => const FontTestScreen(), // Font test screen
            '/gfm-test': (context) => FutureBuilder<Article>(
              future: ArticleService.getGfmTestArticle(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ArticleScreen(article: snapshot.data!);
                } else {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ), // GFM test article screen
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
      },
    );
  }

  ThemeData _buildLightTheme(BuildContext context) {
    // 基础颜色方案
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    );
    
    return ThemeData(
      colorScheme: baseColorScheme,
      useMaterial3: true,
      // Use NotoSansSC as default font for better Chinese support with increased weight
      fontFamily: 'NotoSansSC',
      textTheme: const TextTheme(
        // Increase default font weight for better readability using fontVariations
        bodyLarge: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
        bodyMedium: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
        bodySmall: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
        titleLarge: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
        titleMedium: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
        titleSmall: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
      ),
      // 设置AppBar主题以实现沉浸式状态栏
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // 去除状态栏遮罩
          statusBarIconBrightness: Brightness.dark, // 状态栏图标字体颜色
          systemNavigationBarColor: baseColorScheme.surface, // 底部导航栏颜色
        ),
      ),
      // Customize NavigationBar label style
      navigationBarTheme: const NavigationBarThemeData(
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.w500,
            fontVariations: [FontVariation('wght', 500.0)],
            fontSize: 12.0,
          ),
        ),
      ),
      // Customize NavigationRail label style
      navigationRailTheme: const NavigationRailThemeData(
        selectedLabelTextStyle: TextStyle(
          fontFamily: 'NotoSansSC',
          fontWeight: FontWeight.w500,
          fontVariations: [FontVariation('wght', 500.0)],
          color: Colors.black, // 显式设置为黑色
          fontSize: 12.0,
        ),
        unselectedLabelTextStyle: TextStyle(
          fontFamily: 'NotoSansSC',
          fontWeight: FontWeight.w500,
          fontVariations: [FontVariation('wght', 500.0)],
          color: Colors.black, // 显式设置为黑色
          fontSize: 12.0,
        ),
      ),
      // Customize button styles to increase font weight
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontVariations: [FontVariation('wght', 600.0)],
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontVariations: [FontVariation('wght', 600.0)],
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(
            fontVariations: [FontVariation('wght', 600.0)],
          ),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme(BuildContext context) {
    // 基础颜色方案
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    );
    
    return ThemeData(
      colorScheme: baseColorScheme,
      useMaterial3: true,
      // Use NotoSansSC as default font for better Chinese support with increased weight
      fontFamily: 'NotoSansSC',
      textTheme: const TextTheme(
        // Increase default font weight for better readability using fontVariations
        bodyLarge: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
        bodyMedium: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
        bodySmall: TextStyle(fontVariations: [FontVariation('wght', 500.0)]),
        titleLarge: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
        titleMedium: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
        titleSmall: TextStyle(fontVariations: [FontVariation('wght', 600.0)]),
      ),
      // 设置AppBar主题以实现沉浸式状态栏
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: baseColorScheme.surface,  // 和主背景surface保持一致
        )
      ),
      // Customize NavigationBar label style
      navigationBarTheme: const NavigationBarThemeData(
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontWeight: FontWeight.w500,
            fontVariations: [FontVariation('wght', 500.0)],
            fontSize: 12.0,
          ),
        ),
      ),
      // Customize NavigationRail label style
      navigationRailTheme: const NavigationRailThemeData(
        selectedLabelTextStyle: TextStyle(
          fontFamily: 'NotoSansSC',
          fontWeight: FontWeight.w500,
          fontVariations: [FontVariation('wght', 500.0)],
          color: Colors.white, // 显式设置为白色
          fontSize: 12.0,
        ),
        unselectedLabelTextStyle: TextStyle(
          fontFamily: 'NotoSansSC',
          fontWeight: FontWeight.w500,
          fontVariations: [FontVariation('wght', 500.0)],
          color: Colors.white, // 显式设置为白色
          fontSize: 12.0,
        ),
      ),
      // Customize button styles to increase font weight
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontVariations: [FontVariation('wght', 600.0)],
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontVariations: [FontVariation('wght', 600.0)],
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(
            fontVariations: [FontVariation('wght', 600.0)],
          ),
        ),
      ),
    );
  }
}