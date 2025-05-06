import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:beanchain/features/coffee/data/models/stage.dart';

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
  region: 'Sidamo',
  farmAltitude: 1500,
  beanType: 'Arabica',
  harvestYear: 2024,
  initialPrice: 15.0,
  description:
      'Premium grade Ethiopian Sidamo coffee with rich, aromatic flavor.',
  currentStage: 2,
);
