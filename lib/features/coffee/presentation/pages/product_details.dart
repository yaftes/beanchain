import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:beanchain/features/coffee/presentation/pages/price_breakdown.dart';
import 'package:beanchain/features/coffee/presentation/pages/stage_detail.dart';
import 'package:beanchain/features/coffee/presentation/pages/supply_chain_management.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedStageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final stage = product.stages[selectedStageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Product Details",
            style: TextStyle(color: Colors.brown),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Fancy image with overlay title and description
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/coffee_typess.jpg",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Info grid
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 55, // Minimized height
            ),
            children: [
              _InfoBox(label: 'Region', value: product.region),
              _InfoBox(label: 'Altitude', value: '${product.farmAltitude}m'),
              _InfoBox(label: 'Bean Type', value: product.beanType),
              _InfoBox(
                label: 'Harvest Year',
                value: product.harvestYear.toString(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Farm → Retail Price
          Row(
            children: [
              _PriceBox(
                label: "Farm Price",
                price: product.initialPrice,
                color: Colors.green,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward, color: Colors.grey),
              const Spacer(),
              _PriceBox(
                label: "Retail Price",
                price: product.finalPrice,
                color: Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Timeline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Supply Chain Journey",
              style: TextStyle(color: Colors.brown),
            ),
          ),
          const SizedBox(height: 8),
          SupplyChainTimeline(
            stages: product.stages,
            currentStage: "${product.currentStage}",
            onStageTap: (i) => setState(() => selectedStageIndex = i),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Stage Details", style: TextStyle(color: Colors.brown)),
          ),
          const SizedBox(height: 8),
          StageDetail(stage: stage),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Price Breakdown",
              style: TextStyle(color: Colors.brown),
            ),
          ),
          const SizedBox(height: 8),
          PriceBreakdown(stages: product.stages),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 9.5,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class _PriceBox extends StatelessWidget {
  final String label;
  final double price;
  final Color color;

  const _PriceBox({
    required this.label,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: color)),
          const SizedBox(height: 4),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
