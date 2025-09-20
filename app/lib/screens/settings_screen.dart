import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../utils/animal_version.dart';

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode)? updateThemeMode;
  final Function(bool)? updateDynamicColor;

  const SettingsScreen({super.key, this.updateThemeMode, this.updateDynamicColor});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _baseUrlController;
  
  // Theme settings
  ThemeMode _themeMode = ThemeMode.system;
  bool _useDynamicColor = true; // 默认启用动态颜色
  
  // Reading settings
  bool _enablePageTurnAnimation = true;

  @override
  void initState() {
    super.initState();
    _baseUrlController = TextEditingController(text: ApiService.baseUrl);
    _loadSettings();
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    super.dispose();
  }

  // Load settings from shared preferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('themeMode') ?? 0;
    setState(() {
      _themeMode = ThemeMode.values[themeModeIndex];
      _useDynamicColor = prefs.getBool('useDynamicColor') ?? true;
      _enablePageTurnAnimation = prefs.getBool('enablePageTurnAnimation') ?? true;
    });
  }

  // Save settings to shared preferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', _themeMode.index);
    await prefs.setBool('useDynamicColor', _useDynamicColor);
    await prefs.setBool('enablePageTurnAnimation', _enablePageTurnAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'API 设置',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontVariations: [FontVariation('wght', 700.0)],
                      ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _baseUrlController,
                  decoration: const InputDecoration(
                    labelText: 'API 基础 URL',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入 API 基础 URL';
                    }
                    // Basic URL validation
                    try {
                      final uri = Uri.parse(value);
                      if (uri.host.isEmpty) {
                        return '请输入有效的 URL';
                      }
                    } catch (e) {
                      return '请输入有效的 URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveApiSettings,
                    child: const Text('保存 API 设置'),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                
                // Display settings
                Text(
                  '显示设置',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('主题模式'),
                  trailing: DropdownButton<ThemeMode>(
                    value: _themeMode,
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('跟随系统'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('浅色模式'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('深色模式'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _themeMode = value;
                        });
                        _saveSettings();
                        // Call the callback to update theme mode in main app
                        widget.updateThemeMode?.call(value);
                      }
                    },
                  ),
                ),
                SwitchListTile(
                  title: const Text('动态颜色 (Material You)'),
                  subtitle: const Text('使用壁纸颜色生成主题'),
                  value: _useDynamicColor,
                  onChanged: (value) {
                    setState(() {
                      _useDynamicColor = value;
                    });
                    _saveSettings();
                    // Call the callback to update dynamic color setting in main app
                    widget.updateDynamicColor?.call(value);
                    // Show a message that the app needs to be restarted
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('重启应用以应用动态颜色设置'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                
                // Reading settings
                Text(
                  '阅读设置',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('翻页动画'),
                  value: _enablePageTurnAnimation,
                  onChanged: (value) {
                    setState(() {
                      _enablePageTurnAnimation = value;
                    });
                    _saveSettings();
                  },
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                
                // About section
                Text(
                  '关于',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                ),
                const SizedBox(height: 16),
                // 版本信息 - 放在关于标题正下方
                FutureBuilder<String>(
                  future: AnimalVersion.getDisplayVersion(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        title: const Text('版本信息'),
                        subtitle: Text(snapshot.data!),
                      );
                    } else {
                      return const ListTile(
                        title: Text('版本信息'),
                        subtitle: Text('加载中...'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement feedback functionality
                    },
                    child: const Text('意见反馈'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '使用说明',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontVariations: [FontVariation('wght', 600.0)],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• 在本地开发时，通常使用 http://localhost:8001 或 http://127.0.0.1:8001\n'
                  '• 在模拟器中访问本地服务器时，可能需要使用 http://10.0.2.2:8001 (Android) 或宿主机 IP\n'
                  '• 在真机调试时，需要确保手机和电脑在同一局域网，并使用电脑的局域网 IP 地址，如 http://192.168.1.100:8001',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24), // 添加一些底部间距
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveApiSettings() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService.setBaseUrl(_baseUrlController.text);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('API 设置已保存')),
          );
          // Pop the screen after a short delay
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('保存失败: $e')),
          );
        }
      }
    }
  }
}