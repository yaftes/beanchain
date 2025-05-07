import 'package:beanchain/core/mock_data.dart';
import 'package:beanchain/features/coffee/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _cameraController = MobileScannerController();
  bool _isScanning = true;
  bool _isLoading = false;

  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning || _isLoading) return;
    final barcode = capture.barcodes.first;
    final String? rawValue = barcode.rawValue;

    if (rawValue != null) {
      setState(() {
        _isScanning = false;
        _isLoading = true;
      });

      _fetchProductDetailsAndNavigate(rawValue);
    }
  }

  void _fetchProductDetailsAndNavigate(String productId) async {
    // Simulate fetching from backend (e.g., GET api/coffee/{productId})
    print("Fetching details from api/coffee/$productId");

    await Future.delayed(Duration(seconds: 2)); // simulate API

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: mockProduct),
      ),
    ).then((_) {
      setState(() {
        _isLoading = false;
        _isScanning = true;
      });
    });
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
        title: Text(
          'Scan Coffee QR',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.brown[700],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _cameraController,
            fit: BoxFit.cover,
            onDetect: _onDetect,
          ),

          // Overlay Box
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
