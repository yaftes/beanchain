class Stage {
  final String stage;
  final String company;
  final String location;
  final DateTime date_completed;
  final String status;
  final double price_after_stage;

  Stage({
    required this.stage,
    required this.company,
    required this.location,
    required this.date_completed,
    required this.status,
    required this.price_after_stage,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      stage: json['stage'],
      company: json['company'],
      location: json['location'],
      date_completed: DateTime.parse(json['date_completed']),
      status: json['status'],
      price_after_stage: (json['price_after_stage'] as num).toDouble(),
    );
  }
}
