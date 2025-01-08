import 'package:flutter/foundation.dart';
import 'package:hundred_flutter_logic/features/api_logic/model/product_model.dart';
import 'package:hundred_flutter_logic/features/api_logic/services/dummyjson_api_service.dart';

class ProductProvider extends ChangeNotifier{
  final DummyJsonApiService _apiService = DummyJsonApiService();
  List<Product> _products = [];
  Product? _singleProduct;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<Product> get products => _products;
  Product? get singleProduct => _singleProduct;

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
}