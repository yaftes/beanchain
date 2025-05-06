class Stage {
  final String id;
  final String name;
  final String location;
  final DateTime timestamp;
  final String details;
  final double price;

  Stage({
    required this.id,
    required this.name,
    required this.location,
    required this.timestamp,
    required this.details,
    required this.price,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      timestamp: DateTime.parse(json['timestamp']),
      details: json['details'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'timestamp': timestamp.toIso8601String(),
      'details': details,
      'price': price,
    };
  }
}
