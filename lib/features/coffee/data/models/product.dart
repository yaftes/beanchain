import 'package:beanchain/features/coffee/data/models/stage.dart';

class Product {
  final String id;
  final String name;
  final String origin;
  final List<Stage> stages;
  final double finalPrice;
  final String imageUrl;
  final List<String> certifications;
  final String region;
  final int farmAltitude;
  final String beanType;
  final int harvestYear; // Make sure this is an int
  final double initialPrice;
  final String description; // This should be a String, make sure it's not null
  final int currentStage; // This should be an int

  Product({
    required this.id,
    required this.name,
    required this.origin,
    required this.stages,
    required this.finalPrice,
    required this.imageUrl,
    required this.certifications,
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
      id: json['id'] ?? '', // Ensure the ID is also passed
      name: json['name'] ?? 'Unknown', // Default name if not available
      origin: json['origin'] ?? 'Unknown origin', // Default origin
      finalPrice:
          (json['finalPrice'] is num)
              ? (json['finalPrice'] as num).toDouble()
              : 0.0,
      stages: (json['stages'] as List).map((e) => Stage.fromJson(e)).toList(),
      imageUrl: json['imageUrl'] ?? '',
      certifications: List<String>.from(json['certifications'] ?? []),
      region: json['region'] ?? 'Unknown region',
      farmAltitude: json['farmAltitude'] ?? 0,
      beanType: json['beanType'] ?? 'Unknown type',
      harvestYear: json['harvestYear'] ?? 0, // Default to 0 if not provided
      initialPrice:
          (json['initialPrice'] is num)
              ? (json['initialPrice'] as num).toDouble()
              : 0.0,
      description:
          json['description'] ??
          'No description available', // Default description
      currentStage: json['currentStage'] ?? 0, // Default to 0 if not provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'origin': origin,
      'finalPrice': finalPrice,
      'stages':
          stages
              .map((e) => e.toJson())
              .toList(), // Include stages data in toJson
      'imageUrl': imageUrl,
      'certifications': certifications,
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
