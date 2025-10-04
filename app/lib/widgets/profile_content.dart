import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/user_provider.dart';
import '../services/user_service.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
            children: [
              const _ProfileHeader(),
              // 横屏模式下选项已经在_ProfileHeader中显示，不需要重复
              const _ProfileOptionsConditional(),
            ],
          ),
        );
      },
    );
  }
}

// 条件显示选项列表的组件
class _ProfileOptionsConditional extends StatelessWidget {
  const _ProfileOptionsConditional();

  @override
  Widget build(BuildContext context) {
    // 在横屏模式下不显示选项列表，因为已经在_ProfileHeader中显示了
    // 这里需要通过父级传递屏幕宽度信息，或者使用MediaQuery来判断
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // 横屏模式下不显示，因为选项已经在_ProfileHeader中显示
          return const SizedBox.shrink();
        } else {
          // 竖屏模式下显示选项列表
          return const _ProfileOptions();
        }
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 600;
            
            if (isWideScreen) {
              // 横屏模式：不使用卡片样式，保持原有布局
              return Container(
                margin: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 左半边：用户信息
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: (userProvider.user != null)
                            ? Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: CachedNetworkImageProvider(
                                      'https://via.placeholder.com/100',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userProvider.user!.username,
                                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(userProvider.user!.email ?? 'user@example.com'),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '未登录',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16),
                                  Text('登录后享受更多功能'),
                                ],
                              ),
                      ),
                    ),
                    // 右半边：选项列表
                    Expanded(
                      flex: 1,
                      child: _ProfileOptionsConditionalWide(),
                    ),
                  ],
                ),
              );
            } else {
              // 竖屏模式：不使用卡片样式，保持居中布局
              return Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: (userProvider.user != null)
                        ? Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                  'https://via.placeholder.com/100',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userProvider.user!.username,
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(userProvider.user!.email ?? 'user@example.com'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                '未登录',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              const Text('登录后享受更多功能'),
                            ],
                          ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

// 隐藏详细信息组件
/*
class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '详细信息',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('注册时间: 2023-01-01'),
          Text('阅读文章: 100'),
          Text('点赞数: 50'),
        ],
      ),
    );
  }
}
*/

// 隐藏订阅信息组件
/*
class _SubscriptionStatus extends StatelessWidget {
  const _SubscriptionStatus();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '订阅信息',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('状态: 有效'),
          Text('到期时间: 2024-01-01'),
        ],
      ),
    );
  }
}
*/

// 横屏模式下的选项组件
class _ProfileOptionsHorizontal extends StatelessWidget {
  const _ProfileOptionsHorizontal();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (userProvider.user != null) ...[
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('阅读历史'),
                  onTap: () {
                    // TODO: Implement reading history
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('设置'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('退出登录'),
                  onTap: () async {
                    await UserService.logout();
                    userProvider.clearUser();
                    
                    // 显示成功提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('已退出登录')),
                    );
                  },
                ),
              ] else ...[
                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('登录'),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.app_registration),
                  title: const Text('注册'),
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('设置'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _ProfileOptions extends StatelessWidget {
  const _ProfileOptions();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              if (userProvider.user == null) ...[
                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('登录'),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.app_registration),
                  title: const Text('注册'),
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('设置'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ] else ...[
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('阅读历史'),
                  onTap: () {
                    // TODO: Implement reading history
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('设置'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('退出登录'),
                  onTap: () async {
                    await UserService.logout();
                    userProvider.clearUser();
                    
                    // 显示成功提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('已退出登录')),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// 横屏模式下的条件选项组件
class _ProfileOptionsConditionalWide extends StatelessWidget {
  const _ProfileOptionsConditionalWide();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return (userProvider.user != null) 
            ? const _ProfileOptionsHorizontal() 
            : const _LoginOption();
      },
    );
  }
}

// 未登录时显示的登录选项组件
class _LoginOption extends StatelessWidget {
  const _LoginOption();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('登录'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('注册'),
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('设置'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}