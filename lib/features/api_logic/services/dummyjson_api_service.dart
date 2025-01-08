import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hundred_flutter_logic/features/api_logic/model/dummy_json_model.dart';
import 'package:hundred_flutter_logic/features/api_logic/model/product_model.dart';

class DummyJsonApiService {
  final String baseUrl = 'https://dummyjson.com';

  // https://dummyjson.com/products?limit=10&page=1

  // Get all products

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> fetchProductById(num id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }



  // Post request
  /*
  Future<void> addProduct({
    required String title,
    required String description,
    required String category,
    required num price,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products/add'),
        headers: {'Accept': 'application/json'},
        body: {
          title = 'My 1st Post Request Create',
          description = 'Wow Look in like wow',
          category = 'Iqbal',
          price = 100,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Create a post');
      } else {
        throw Exception('Failed post data');
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }

   */
}

/*

  Future<List<ProductsModel>?> fetchAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final products = data['products'] as List;
        return products.map((product) => ProductsModel.fromJson(products),).toList();
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }

  // Get request
  Future<List<dynamic>> fetchProducts({int page = 1, int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?limit=$limit&page=$page'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['products'];
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }

  // Search Function
  //https://dummyjson.com/products/search?q=Eyeshadow%20Palette%20with%20Mirror
  Future<List<dynamic>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search?q=$query'),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['products'];
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }
}

 */
