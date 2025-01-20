import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/home.dart';

class HomePage extends Page<void> {
  const HomePage();

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const ProviderScope(
        child: HomeView(),
      ),
    );
  }
}
