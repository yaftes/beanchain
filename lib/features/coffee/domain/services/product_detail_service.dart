import 'dart:convert';
import 'package:beanchain/core/debugger.dart';
import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  Future<Product?> fetchProduct({
    required String chainId,
    required int id,
  }) async {
    final url = Uri.parse(
      'https://lenient-blatantly-parrot.ngrok-free.app/api/products/$chainId/$id/all',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 15));

      debugPrintColor('🔍 Request URL: $url');
      debugPrintColor('📦 Status Code: ${response.statusCode}');
      debugPrintColor('📥 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return Product.fromJson(data);
      } else {
        debugPrintColor(
          '❌ Failed to load product. Status code: ${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      debugPrintColor('🚨 Error fetching product: $e');
      return null;
    }
  }
}
