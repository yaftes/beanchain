import 'package:beanchain/core/mock_data.dart';
import 'package:beanchain/features/coffee/data/models/stage.dart';
import 'package:beanchain/features/coffee/presentation/pages/home_page.dart';
import 'package:beanchain/features/coffee/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:beanchain/features/coffee/data/models/product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
