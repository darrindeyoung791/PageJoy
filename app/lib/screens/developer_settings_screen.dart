import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import '../utils/animal_version.dart';

class DeveloperSettingsScreen extends StatefulWidget {
  const DeveloperSettingsScreen({super.key});

  @override
  State<DeveloperSettingsScreen> createState() => _DeveloperSettingsScreenState();
}

class _DeveloperSettingsScreenState extends State<DeveloperSettingsScreen> {
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
        title: const Text('开发设置'),
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
                  // API设置部分
                  _buildSectionHeader(context, 'API'),
                  _buildTextSetting(
                    context,
                    'API 基础 URL',
                    '配置后端API服务地址',
                    _baseUrlController,
                    (value) {
                      // 验证输入
                      if (value == null || value.isEmpty) {
                        return '请输入 API 基础 URL';
                      }
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
                  _buildSaveButton(context),
                  const SizedBox(height: 24),
                  
                  // 测试页面部分
                  _buildSectionHeader(context, '测试'),
                  _buildNavigationSetting(
                    context,
                    'GFM 测试',
                    '查看 GitHub Flavored Markdown 渲染效果',
                    '/gfm-test',
                  ),
                  _buildNavigationSetting(
                    context,
                    '字体测试',
                    '查看字体渲染效果',
                    '/font-test',
                  ),
                  const SizedBox(height: 24),
                  
                  // 使用说明部分
                  _buildSectionHeader(context, '使用说明'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '• 在本地开发时，通常使用 http://localhost:8001 或 http://127.0.0.1:8001\n'
                      '• 在模拟器中访问本地服务器时，可能需要使用 http://10.0.2.2:8001 (Android) 或宿主机 IP\n'
                      '• 在真机调试时，需要确保手机和电脑在同一局域网，并使用电脑的局域网 IP 地址，如 http://192.168.1.100:8001',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
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

  // 构建文本输入设置项
  Widget _buildTextSetting(
    BuildContext context,
    String title,
    String subtitle,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  // 构建保存按钮
  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: SizedBox(
          width: 200, // 固定宽度以符合设计规范
          child: ElevatedButton(
            onPressed: _saveApiSettings,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 0, // 移除阴影
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // MD3推荐的圆角
              ),
              padding: const EdgeInsets.symmetric(vertical: 16), // 增加按钮高度
            ),
            child: Text(
              '保存 API 设置',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSansSC', // 使用Noto Sans SC字体
              ),
            ),
          ),
        ),
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

  void _saveApiSettings() async {
    String? validationError;
    if (_baseUrlController.text.isEmpty) {
      validationError = '请输入 API 基础 URL';
    } else {
      try {
        final uri = Uri.parse(_baseUrlController.text);
        if (uri.host.isEmpty) {
          validationError = '请输入有效的 URL';
        }
      } catch (e) {
        validationError = '请输入有效的 URL';
      }
    }
    
    if (validationError != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(validationError)),
        );
      }
      return;
    }

    try {
      await ApiService.setBaseUrl(_baseUrlController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('API 设置已保存')),
        );
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