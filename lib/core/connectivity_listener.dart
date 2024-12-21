import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'connectivity_provider.dart';
import 'error_widget_custom.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivity, _) {
        if (connectivity.isOnline) {
          return MaterialApp(
            home: child,
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: ErrorWidgetCustom(
                message: 'No internet connection. Please check your settings.',
                onRetry: () {
                  connectivity.checkConnectivity();
                },
              ),
            ),
          );
        }
      },
    );
  }
}
