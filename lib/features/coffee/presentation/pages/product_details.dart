import 'package:beanchain/features/auth/presentation/pages/auth_gate.dart';
import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:beanchain/features/coffee/presentation/pages/issue_report_page.dart';
import 'package:beanchain/features/coffee/presentation/widgets/info_box.dart';
import 'package:beanchain/features/coffee/presentation/widgets/price_box.dart';
import 'package:beanchain/features/coffee/presentation/widgets/price_breakdown.dart';
import 'package:beanchain/features/coffee/presentation/widgets/stage_detail.dart';
import 'package:beanchain/features/coffee/presentation/widgets/supply_chain_management.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Colors.brown,
        title: Center(
          child: const Text(
            "Product Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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

          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 55,
            ),
            children: [
              InfoBox(label: 'Region', value: product.region),
              InfoBox(label: 'Altitude', value: '${product.farmAltitude}m'),
              InfoBox(label: 'Bean Type', value: product.beanType),
              InfoBox(
                label: 'Harvest Year',
                value: product.harvestYear.toString(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              PriceBox(
                label: "Farm Price",
                price: product.initialPrice,
                color: Colors.green,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward, color: Colors.grey),
              const Spacer(),
              PriceBox(
                label: "Retail Price",
                price: product.finalPrice,
                color: Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 15),

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
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthGate()),
                  );
                },
                icon: const Icon(Icons.feedback_rounded, color: Colors.white),
                label: Text(
                  "Report an Issue",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[700],
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
