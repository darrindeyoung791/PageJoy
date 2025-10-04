import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/user_provider.dart';
import '../services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      try {
        // 调用注册API
        final user = await UserService.register(
          _usernameController.text.trim(),
          _passwordController.text,
          email: _emailController.text.trim(),
        );

        // 注册成功后自动登录
        final loginResult = await UserService.login(
          _usernameController.text.trim(),
          _passwordController.text,
        );

        // 更新用户状态
        final userProvider = context.read<UserProvider>();
        userProvider.setUser(loginResult);

        // 注册成功，跳转到登录页面
        if (mounted) {
          // 显示成功提示
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('注册成功')),
          );
          // 跳转到登录页面
          Navigator.pushNamed(context, '/login');
        }
      } catch (e) {
        // 注册失败，显示错误信息
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('注册失败: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // 限制最大宽度为400dp
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: '用户名',
                      border: OutlineInputBorder(),
                      counterText: '', // 隐藏长度指示器
                    ),
                    maxLength: 100,
                    enabled: !_isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入用户名';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: '邮箱',
                      border: OutlineInputBorder(),
                      counterText: '', // 隐藏长度指示器
                    ),
                    maxLength: 100,
                    enabled: !_isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入邮箱';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return '请输入有效的邮箱地址';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: '密码',
                      border: OutlineInputBorder(),
                      counterText: '', // 隐藏长度指示器
                    ),
                    maxLength: 100,
                    obscureText: true,
                    enabled: !_isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入密码';
                      }
                      if (value.length < 6) {
                        return '密码至少需要6个字符';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: '确认密码',
                      border: OutlineInputBorder(),
                      counterText: '', // 隐藏长度指示器
                    ),
                    maxLength: 100,
                    obscureText: true,
                    enabled: !_isLoading,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请确认密码';
                      }
                      if (value != _passwordController.text) {
                        return '密码不匹配';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity, // 与输入框同宽
                          child: ElevatedButton(
                            onPressed: _register,
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
                              '注册',
                              style: TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.w500,
                                fontFamily: 'NotoSansSC', // 使用Noto Sans SC字体
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: !_isLoading
                        ? () {
                            Navigator.pushNamed(context, '/login');
                          }
                        : null,
                    child: const Text('已有账户？登录'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}