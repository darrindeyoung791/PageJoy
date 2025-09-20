import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth > 600;
        
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
        final bool isWideScreen = constraints.maxWidth > 600;
        
        if (isWideScreen) {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth > 600;
        
        if (isWideScreen) {
          // 横屏模式：完整卡片
          return Card(
            margin: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左半边：用户信息
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                              const Text(
                                '用户名',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text('user@example.com'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 右半边：选项列表
                const Expanded(
                  flex: 1,
                  child: _ProfileOptionsHorizontal(),
                ),
              ],
            ),
          );
        } else {
          // 竖屏模式：居中卡片，接近屏幕宽度
          return Center(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
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
                          const Text(
                            '用户名',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text('user@example.com'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '选项',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
            onTap: () {
              // TODO: Implement logout
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileOptions extends StatelessWidget {
  const _ProfileOptions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '选项',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
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
            onTap: () {
              // TODO: Implement logout
            },
          ),
        ],
      ),
    );
  }
}