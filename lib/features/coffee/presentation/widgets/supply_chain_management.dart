import 'package:beanchain/features/coffee/data/models/stage.dart';
import 'package:flutter/material.dart';

class SupplyChainTimeline extends StatelessWidget {
  final List<Stage> stages;
  final String currentStage;
  final void Function(int) onStageTap;

  const SupplyChainTimeline({
    super.key,
    required this.stages,
    required this.currentStage,
    required this.onStageTap,
  });

  IconData _getStageIcon(String stageName) {
    switch (stageName.toLowerCase()) {
      case 'farming':
        return Icons.agriculture;
      case 'processing':
        return Icons.precision_manufacturing;
      case 'shipping':
        return Icons.local_shipping;
      case 'roasting':
        return Icons.local_fire_department;
      case 'retail':
        return Icons.storefront;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stages.length,
        itemBuilder: (context, index) {
          final stage = stages[index];
          final isActive = stage.name == currentStage;
          final isCompleted =
              stages.indexWhere((s) => s.name == currentStage) > index;

          return InkWell(
            onTap: () => onStageTap(index),
            child: Row(
              children: [
                if (index != 0)
                  Container(
                    width: 30,
                    height: 4,
                    color:
                        isCompleted || isActive
                            ? Colors.orange
                            : Colors.grey[300],
                  ),
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isActive
                                ? Colors.orange
                                : isCompleted
                                ? Colors.orange.withOpacity(0.5)
                                : Colors.grey[200],
                        boxShadow:
                            isActive
                                ? [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                                : [],
                      ),
                      child: Icon(
                        _getStageIcon(stage.name),
                        size: 26,
                        color:
                            isActive
                                ? Colors.white
                                : isCompleted
                                ? Colors.white
                                : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 70,
                      child: Text(
                        stage.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isActive
                                  ? Colors.orange
                                  : isCompleted
                                  ? Colors.orange.withOpacity(0.7)
                                  : Colors.black87,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
