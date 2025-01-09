import 'package:flutter/foundation.dart';
import 'package:hundred_flutter_logic/features/api_logic/model/product_model.dart';
import 'package:hundred_flutter_logic/features/api_logic/services/dummyjson_api_service.dart';

class ProductProvider extends ChangeNotifier{
  final DummyJsonApiService _apiService = DummyJsonApiService();
  List<Product> _products = [];
  Product? _singleProduct;
  Map<String, dynamic>? _createPost;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<Product> get products => _products;
  Product? get singleProduct => _singleProduct;
  Map<String, dynamic>? get createPost => _createPost;

  Future<void> fetchProduct() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
    } catch (e) {
      print('error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductById(num id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _singleProduct = await _apiService.fetchProductById(id);
    } catch (e) {
      print('error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.createProduct(productData);
      _createPost = response;
    } catch (e) {
      print('error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}