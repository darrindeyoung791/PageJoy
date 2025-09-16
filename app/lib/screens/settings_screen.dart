import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For FontVariation
import '../services/api_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _baseUrlController;

  @override
  void initState() {
    super.initState();
    _baseUrlController = TextEditingController(text: ApiService.baseUrl);
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    super.dispose();
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
      body: Padding(
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
                  onPressed: _saveSettings,
                  child: const Text('保存设置'),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
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
            ],
          ),
        ),
      ),
    );
  }

  void _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService.setBaseUrl(_baseUrlController.text);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('设置已保存')),
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