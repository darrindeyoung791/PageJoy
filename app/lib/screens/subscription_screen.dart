import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订阅'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // 添加平滑滚动物理效果
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CurrentSubscription(),
            _SubscriptionPlans(),
          ],
        ),
      ),
    );
  }
}

class _CurrentSubscription extends StatelessWidget {
  const _CurrentSubscription();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '当前订阅',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('套餐: 高级版'),
          Text('状态: 有效'),
          Text('到期时间: 2024-01-01'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: null, // TODO: Implement cancel subscription
            child: Text('取消订阅'),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionPlans extends StatelessWidget {
  const _SubscriptionPlans();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '可用套餐',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // TODO: Implement subscription plans list
          Text('可用订阅套餐列表'),
        ],
      ),
    );
  }
}