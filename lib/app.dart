import 'package:beanchain/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // Mock Product data

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
