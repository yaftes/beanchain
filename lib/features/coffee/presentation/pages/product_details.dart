import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'coffee-animation-${widget.product.id}',
              child: Center(
                child: SizedBox(
                  height: 180,
                  child: Lottie.asset("assets/lottie/coffee_beat.json"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.description,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            _buildInfoRow(Icons.public, "Origin", widget.product.origin),
            _buildInfoRow(
              Icons.terrain,
              "Altitude",
              widget.product.altitude.toString(),
            ),
            _buildInfoRow(Icons.coffee, "Bean Type", widget.product.bean_type),
            _buildInfoRow(
              Icons.calendar_today,
              "Harvest Year",
              widget.product.harvest_year.toString(),
            ),
            const SizedBox(height: 24),
            Text(
              "Supply Chain Journey",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 12),
            for (var stage in stages) _buildStageCard(stage),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.brown),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageCard(Stage stage) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            const SizedBox(height: 6),
            Text("Company: ${stage.company}", style: GoogleFonts.poppins()),
            Text("Location: ${stage.location}", style: GoogleFonts.poppins()),
            Text(
              "Date Completed: ${stage.date_completed.toLocal().toShortDateString()}",
              style: GoogleFonts.poppins(),
            ),
            Text("Status: ${stage.status}", style: GoogleFonts.poppins()),
            Text(
              "Price After Stage: \$${double.tryParse(stage.price_after_stage.toString()) != null ? double.parse(stage.price_after_stage.toString()).toStringAsFixed(2) : stage.price_after_stage}",
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
