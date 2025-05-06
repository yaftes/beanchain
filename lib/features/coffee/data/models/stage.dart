class Stage {
  final String id; // Added id as part of the class
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

  // Factory method to create a Stage from a JSON object
  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['id'], // Parsing the id from the JSON
      name: json['name'],
      location: json['location'],
      timestamp: DateTime.parse(json['timestamp']),
      details: json['details'],
      price: (json['price'] as num).toDouble(),
    );
  }

  // Method to convert Stage to JSON
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
