import 'package:beanchain/features/auth/presentation/pages/auth_gate.dart';
import 'package:beanchain/features/coffee/data/models/product.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Product Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
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
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(color: Colors.black38, blurRadius: 6),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13,
                        shadows: const [
                          Shadow(color: Colors.black26, blurRadius: 3),
                        ],
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
              mainAxisExtent: 70,
            ),
            children: [
              _fancyCard(InfoBox(label: 'Region', value: product.region)),
              _fancyCard(
                InfoBox(label: 'Altitude', value: '${product.farmAltitude}m'),
              ),
              _fancyCard(InfoBox(label: 'Bean Type', value: product.beanType)),
              _fancyCard(
                InfoBox(
                  label: 'Harvest Year',
                  value: product.harvestYear.toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: _fancyDecoration(),
            child: Row(
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
          ),

          const SizedBox(height: 20),

          Text(
            "Supply Chain Journey",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          _fancyCard(
            SupplyChainTimeline(
              stages: product.stages,
              currentStage: "${product.currentStage}",
              onStageTap: (i) => setState(() => selectedStageIndex = i),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            "Stage Details",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          _fancyCard(StageDetail(stage: stage)),

          const SizedBox(height: 16),
          Text(
            "Price Breakdown",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          _fancyCard(PriceBreakdown(stages: product.stages)),

          const SizedBox(height: 20),
          ElevatedButton.icon(
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
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fancyCard(Widget child) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _fancyDecoration(),
      child: child,
    );
  }

  BoxDecoration _fancyDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(2, 4)),
      ],
    );
  }
}
