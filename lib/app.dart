import 'package:beanchain/features/auth/presentation/pages/login_page.dart';
import 'package:beanchain/features/coffee/data/models/stage.dart';
import 'package:beanchain/features/coffee/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:beanchain/features/coffee/data/models/product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailPage(product: mockProduct),
    );
  }
}

List<Stage> mockStages = [
  Stage(
    id: '1',
    name: 'Harvesting',
    location: 'Ethiopia, Sidamo',
    timestamp: DateTime.now().subtract(Duration(days: 30)),
    details: 'Coffee beans are harvested manually.',
    price: 5.0,
  ),
  Stage(
    id: '2',
    name: 'Processing',
    location: 'Ethiopia, Sidamo',
    timestamp: DateTime.now().subtract(Duration(days: 20)),
    details: 'Beans are processed and sorted.',
    price: 3.5,
  ),
  Stage(
    id: '3',
    name: 'Roasting',
    location: 'Ethiopia, Sidamo',
    timestamp: DateTime.now().subtract(Duration(days: 10)),
    details: 'Beans are roasted at high temperatures.',
    price: 10.0,
  ),
  Stage(
    id: '4',
    name: 'Packaging',
    location: 'Ethiopia, Sidamo',
    timestamp: DateTime.now().subtract(Duration(days: 5)),
    details: 'Beans are packed and ready for shipment.',
    price: 2.0,
  ),
];
Product mockProduct = Product(
  id: 'product-001',
  name: 'Ethiopian Sidamo Coffee',
  origin: 'Ethiopia',
  stages: mockStages,
  finalPrice: 25.0,
  imageUrl: 'https://example.com/images/ethiopian_sidamo_coffee.jpg',
  certifications: ['Organic', 'Fair Trade'],
  region: 'Sidamo',
  farmAltitude: 1500,
  beanType: 'Arabica',
  harvestYear: 2024,
  initialPrice: 15.0,
  description:
      'Premium grade Ethiopian Sidamo coffee with rich, aromatic flavor.',
  currentStage: 2, // Currently at 'Roasting' stage
);
