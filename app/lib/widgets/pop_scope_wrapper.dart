import 'package:flutter/material.dart';

/// A wrapper widget that provides a default implementation of PopScope
/// to enable predictive back gesture support for all screens.
///
/// This widget should be used to wrap all top-level screens in the app
/// to ensure consistent back gesture behavior.
class PopScopeWrapper extends StatelessWidget {
  final Widget child;
  
  const PopScopeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // By default, allow popping for all screens
      canPop: true,
      // Provide a default implementation of onPopInvokedWithResult
      onPopInvokedWithResult: (bool didPop, Object? result) {
        // Add logging to help debug predictive back gesture
        if (didPop) {
          debugPrint('Page popped with result: $result');
        } else {
          debugPrint('Pop was prevented');
        }
      },
      child: child,
    );
  }
}