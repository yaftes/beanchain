import 'package:beanchain/features/coffee/data/models/stage.dart';
import 'package:flutter/material.dart';

class PriceBreakdown extends StatelessWidget {
  final List<Stage> stages;
  const PriceBreakdown({super.key, required this.stages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          stages.map((stage) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Hello",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'Hello',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
