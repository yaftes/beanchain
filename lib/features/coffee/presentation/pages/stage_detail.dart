import 'package:beanchain/features/coffee/data/models/stage.dart';
import 'package:flutter/material.dart';

class StageDetail extends StatelessWidget {
  final Stage stage;
  const StageDetail({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location: ${stage.location}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),

          // Text("Timestamp: ${DateFormat.yMMMd().add_jm().format(stage.timestamp)}"),
          const SizedBox(height: 6),
          Text("Details: ${stage.details}"),
        ],
      ),
    );
  }
}
