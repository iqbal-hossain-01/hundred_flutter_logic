import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/api_logic/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _addProduct(BuildContext context) async {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    final productData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'category': _categoryController.text,
      'price': double.tryParse(_priceController.text) ?? 0.0,
    };

    await provider.addProduct(productData);
    await provider.fetchProduct();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product Added: ${provider.createPost?['title']}')),
    );

    _titleController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ProductProvider>(context).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () => _addProduct(context),
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
