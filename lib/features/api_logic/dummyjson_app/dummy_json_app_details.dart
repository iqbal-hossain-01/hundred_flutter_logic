import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/api_logic/provider/product_provider.dart';
import 'package:provider/provider.dart';

class DummyJsonAppDetails extends StatefulWidget {
  static const String routeName = '/dummy_app_details';
  num? productId;

  DummyJsonAppDetails({super.key, required this.productId});

  @override
  State<DummyJsonAppDetails> createState() => _DummyJsonAppDetailsState();
}

class _DummyJsonAppDetailsState extends State<DummyJsonAppDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchProductById(widget.productId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final isLoading = productProvider.isLoading;
    final singleProduct = productProvider.singleProduct;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : singleProduct == null
              ? const Center(child: Text('Product not found'))
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Card(
                                child: CachedNetworkImage(
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  fadeInCurve: Curves.bounceInOut,
                                  fadeInDuration: const Duration(milliseconds: 1000),
                                  imageUrl: singleProduct.thumbnail ?? '',
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                ),
                              ),
                              if (singleProduct.images != null)
                                for (final image in singleProduct.images!)
                                  Card(
                                    child: CachedNetworkImage(
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      fadeInCurve: Curves.bounceInOut,
                                      fadeInDuration: const Duration(milliseconds: 1000),
                                      imageUrl: image,
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        Text(singleProduct.title!, style: Theme.of(context).textTheme.titleMedium),
                        Text('\$${singleProduct.price!}', style: Theme.of(context).textTheme.titleMedium),
                        Text(singleProduct.description!, textAlign: TextAlign.justify),
                        ListTile(
                          title: const Text('Category'),
                          subtitle: Text(singleProduct.category!),
                        ),
                        ListTile(
                          title: const Text('Brand'),
                          subtitle: Text(singleProduct.brand!),
                        ),
                        ListTile(
                          title: const Text('Stock'),
                          subtitle: Text('${singleProduct.stock!}'),
                        ),
                  
                      ],
                    ),
                ),
              ),
    );
  }
}
