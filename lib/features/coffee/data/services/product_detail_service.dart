import 'dart:convert';
import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  final String baseUrl;
  ProductDetailService({required this.baseUrl});

  Future<Product?> fetchProduct(int productId) async {
    final url = Uri.parse('$baseUrl/products/$productId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        print('Failed to load product. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }
}
