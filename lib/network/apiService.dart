import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myeg_flutter_test/model/productModel.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';


  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}