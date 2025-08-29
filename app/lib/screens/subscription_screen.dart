import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: const SingleChildScrollView(
        child: Column(
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
            'Current Subscription',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Plan: Premium'),
          Text('Status: Active'),
          Text('Expires: 2024-01-01'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: null, // TODO: Implement cancel subscription
            child: Text('Cancel Subscription'),
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
            'Available Plans',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // TODO: Implement subscription plans list
          Text('List of available subscription plans'),
        ],
      ),
    );
  }
}