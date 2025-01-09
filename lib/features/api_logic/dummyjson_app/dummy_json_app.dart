import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/api_logic/dummyjson_app/add_product_page.dart';
import 'package:hundred_flutter_logic/features/api_logic/dummyjson_app/dummy_json_app_details.dart';
import 'package:hundred_flutter_logic/features/api_logic/provider/product_provider.dart';
import 'package:provider/provider.dart';

class DummyJsonApp extends StatelessWidget {
  static const String routeName = '/dummy_json_app';

  const DummyJsonApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('DummyJson App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage(),));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DummyJsonAppDetails(productId: product.id!),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 60,
                              child: CachedNetworkImage(
                                imageUrl: product.thumbnail ??
                                    'https://via.placeholder.com/150',
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Price: \$${product.price!}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Category: ${product.category!}'),
                                Text('Brand: ${product.brand}'),
                                Row(
                                  children: [
                                    const Icon(Icons.star_border, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${product.rating!}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.add_alert_outlined,
                                        size: 20),
                                    Text(product.warrantyInformation!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productProvider.fetchProduct(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
