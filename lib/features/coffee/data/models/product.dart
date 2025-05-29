import 'package:beanchain/features/coffee/data/models/stage.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String origin;
  final int altitude;
  final String bean_type;
  final int harvest_year;
  final List<Stage> journey;

  Product({
    required this.id,
    required this.name,
    required this.origin,
    required this.description,
    required this.altitude,
    required this.bean_type,
    required this.harvest_year,
    required this.journey,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'];
    return Product(
      id: productJson['id'],
      name: productJson['name'],
      origin: productJson['origin'],
      description: productJson['description'],
      altitude: productJson['altitude'],
      bean_type: productJson['bean_type'],
      harvest_year: productJson['harvest_year'],
      journey: (json['journey'] as List).map((e) => Stage.fromJson(e)).toList(),
    );
  }
}
