import 'dart:developer';
import 'package:beanchain/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:beanchain/features/coffee/data/models/stage.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final stages = widget.product.journey;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthGate()),
            ),
        backgroundColor: Colors.brown,
        icon: const Icon(Icons.report, color: Colors.white),
        label: Text(
          "Report Issue",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          widget.product.name,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Hero(
                  tag: 'coffee-animation-${widget.product.id}',

                  child: Center(
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Lottie.asset("assets/lottie/coffee_beat.json"),
                    ),
                  ),
                ),
              ),

              Text(
                widget.product.description,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildGridInfoTile(
                      Icons.public,
                      "Origin",
                      widget.product.origin,
                    ),
                    _buildGridInfoTile(
                      Icons.terrain,
                      "Altitude",
                      "${widget.product.altitude} m",
                    ),
                    _buildGridInfoTile(
                      Icons.coffee,
                      "Bean Type",
                      widget.product.bean_type,
                    ),
                    _buildGridInfoTile(
                      Icons.calendar_today,
                      "Harvest Year",
                      widget.product.harvest_year.toString(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                "Supply Chain Timeline",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < stages.length; i++)
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: i == 0,
                  isLast: i == stages.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: Colors.brown,
                    iconStyle: IconStyle(
                      iconData: Icons.check_circle,
                      color: Colors.white,
                    ),
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Colors.brown,
                    thickness: 2,
                  ),
                  endChild: _buildStageCard(stages[i]),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridInfoTile(IconData icon, String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.brown, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageCard(Stage stage) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stage.stage,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "\u2022 Company: ${stage.company}",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "\u2022 Location: ${stage.location}",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "\u2022 Date: ${stage.date_completed.toLocal().toShortDateString()}",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "\u2022 Status: ${stage.status}",
              style: GoogleFonts.poppins(),
            ),
            Text(
              "\u2022 Price After Stage: \$${double.tryParse(stage.price_after_stage.toString()) != null ? double.parse(stage.price_after_stage.toString()).toStringAsFixed(2) : stage.price_after_stage}",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateFormatExtension on DateTime {
  String toShortDateString() {
    return "${this.day}/${this.month}/${this.year}";
  }
}
