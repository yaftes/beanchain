import 'package:beanchain/features/coffee/data/models/stage.dart';

class Product {
  final String id;
  final String name;
  final String origin;
  final List<Stage> stages;
  final double finalPrice;
  final String region;
  final int farmAltitude;
  final String beanType;
  final int harvestYear;
  final double initialPrice;
  final String description;
  final int currentStage;

  Product({
    required this.id,
    required this.name,
    required this.origin,
    required this.stages,
    required this.finalPrice,
    required this.region,
    required this.farmAltitude,
    required this.beanType,
    required this.harvestYear,
    required this.initialPrice,
    required this.description,
    required this.currentStage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      origin: json['origin'] ?? 'Unknown origin',
      finalPrice:
          (json['finalPrice'] is num)
              ? (json['finalPrice'] as num).toDouble()
              : 0.0,
      stages: (json['stages'] as List).map((e) => Stage.fromJson(e)).toList(),
      region: json['region'] ?? 'Unknown region',
      farmAltitude: json['farmAltitude'] ?? 0,
      beanType: json['beanType'] ?? 'Unknown type',
      harvestYear: json['harvestYear'] ?? 0,
      initialPrice:
          (json['initialPrice'] is num)
              ? (json['initialPrice'] as num).toDouble()
              : 0.0,
      description: json['description'] ?? 'No description available',
      currentStage: json['currentStage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'origin': origin,
      'finalPrice': finalPrice,
      'stages': stages.map((e) => e.toJson()).toList(),
      'region': region,
      'farmAltitude': farmAltitude,
      'beanType': beanType,
      'harvestYear': harvestYear,
      'initialPrice': initialPrice,
      'description': description,
      'currentStage': currentStage,
    };
  }
}
