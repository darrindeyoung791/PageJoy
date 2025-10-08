import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation
import 'package:provider/provider.dart';
import '../models/app_settings.dart';
import '../services/settings_service.dart';
import '../services/offline_mode_provider.dart';

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode)? updateThemeMode;
  final Function(bool)? updateDynamicColor;

  const SettingsScreen({super.key, this.updateThemeMode, this.updateDynamicColor});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppSettings _settings = AppSettings();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from shared preferences
  Future<void> _loadSettings() async {
    final settings = await SettingsService.loadSettings();
    if (mounted) {
      setState(() {
        _settings = settings;
        _isLoading = false;
      });
    }
  }

  // Save settings to shared preferences
  Future<void> _saveSettings() async {
    await SettingsService.saveSettings(_settings);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Section header for Display settings
                  _buildSectionHeader(context, '显示'),
                  _buildDropdownSetting(
                    context,
                    '主题',
                    '根据您的壁纸调整主题',
                    [
                      _DropdownItem('浅色', ThemeMode.light),
                      _DropdownItem('深色', ThemeMode.dark),
                      _DropdownItem('跟随系统', ThemeMode.system),
                    ],
                    _settings.themeMode,
                    (value) {
                      if (value != null) {
                        setState(() {
                          _settings.themeMode = value;
                        });
                        _saveSettings();
                        widget.updateThemeMode?.call(value);
                      }
                    },
                  ),
                  _buildSwitchSetting(
                    context,
                    '动态颜色',
                    '根据您的壁纸调整主题颜色',
                    _settings.useDynamicColor,
                    (value) {
                      setState(() {
                        _settings.useDynamicColor = value;
                      });
                      _saveSettings();
                      widget.updateDynamicColor?.call(value);
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Section header for Reading settings
                  _buildSectionHeader(context, '阅读'),
                  _buildSwitchSetting(
                    context,
                    '离线模式',
                    '在离线模式下使用缓存的数据',
                    _settings.enableOfflineMode,
                    (value) async {
                      setState(() {
                        _settings.enableOfflineMode = value;
                      });
                      _saveSettings();
                      
                      // 更新全局离线模式状态
                      final offlineModeProvider = context.read<OfflineModeProvider>();
                      offlineModeProvider.setOfflineMode(value);
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Section header for Other settings
                  _buildSectionHeader(context, '其他'),
                  _buildNavigationSetting(
                    context,
                    '开发设置',
                    'API配置、测试页面等',
                    '/developer-settings',
                  ),
                  _buildNavigationSetting(
                    context,
                    '关于',
                    '版本信息、致谢等',
                    '/about',
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建分段标题
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  // 构建下拉设置项
  Widget _buildDropdownSetting<T>(
    BuildContext context,
    String title,
    String subtitle,
    List<_DropdownItem<T>> items,
    T currentValue,
    void Function(T?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: DropdownButton<T>(
          value: currentValue,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item.value,
              child: Text(item.label),
            );
          }).toList(),
          onChanged: onChanged,
          underline: const SizedBox(), // Remove the default underline
        ),
      ),
    );
  }

  // 构建开关设置项
  Widget _buildSwitchSetting(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // 构建导航设置项
  Widget _buildNavigationSetting(
    BuildContext context,
    String title,
    String subtitle,
    String route,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}

// 辅助类：下拉项目
class _DropdownItem<T> {
  final String label;
  final T value;

  _DropdownItem(this.label, this.value);
}