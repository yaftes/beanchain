import 'dart:convert';

import 'package:beanchain/core/debugger.dart';
import 'package:beanchain/core/mock_data.dart';
import 'package:beanchain/features/coffee/domain/services/product_detail_service.dart';
import 'package:beanchain/features/coffee/presentation/pages/home_page.dart';
import 'package:beanchain/features/coffee/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final ProductDetailService _productDetailService = ProductDetailService();
  final MobileScannerController _cameraController = MobileScannerController();

  bool _isScanning = true;
  bool _isLoading = false;

  void _onDetect(BarcodeCapture capture) async {
    if (!_isScanning || _isLoading) return;

    final barcode = capture.barcodes.first;
    final String? rawValue = barcode.rawValue;

    if (rawValue == null) return;

    debugPrint("Scanned QR raw value: $rawValue");

    setState(() {
      _isScanning = false;
      _isLoading = true;
    });

    try {
      final decoded = jsonDecode(rawValue);

      if (decoded is! Map ||
          !decoded.containsKey('chainId') ||
          !decoded.containsKey('id')) {
        throw FormatException("Invalid JSON structure");
      }

      final String chainId = decoded['chainId'];
      final int id = decoded['id'];

      debugPrintColor("chainId: $chainId");
      debugPrintColor("id: $id");

      await _fetchProductDetailsAndNavigate(chainId, id);
    } catch (e) {
      debugPrint("Invalid QR data: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid QR code. Please scan a Beanchain coffee QR.'),
        ),
      );

      setState(() {
        _isLoading = false;
      });

      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _isScanning = true;
      });
    }
  }

  Future<void> _fetchProductDetailsAndNavigate(String chainId, int id) async {
    debugPrintColor("Fetching product for chainId: $chainId, id: $id");

    // final product = await _productDetailService.fetchProduct(
    //   chainId: chainId,
    //   id: id,
    // );
    Future.delayed(Duration(seconds: 2));
    final product = mockProduct;

    if (!mounted) return;

    if (product != null) {
      debugPrint("Product found: ${product.name}");

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
      );

      setState(() {
        _isLoading = false;
        _isScanning = true;
      });
    } else {
      debugPrint("Product not found");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product not found for scanned QR')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Scan Coffee QR',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.brown[700],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            fit: BoxFit.cover,
            onDetect: _onDetect,
          ),

          Center(
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _isLoading
                    ? 'Fetching coffee data...'
                    : 'Point camera at coffee QR code',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
