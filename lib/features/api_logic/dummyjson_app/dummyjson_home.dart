// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:hundred_flutter_logic/features/api_logic/services/dummyjson_api_service.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// class DummyJsonHome extends StatefulWidget {
//   static const String routeName = '/dummyJson';
//
//   const DummyJsonHome({super.key});
//
//   @override
//   State<DummyJsonHome> createState() => _DummyJsonHomeState();
// }
//
// class _DummyJsonHomeState extends State<DummyJsonHome> {
//   final DummyJsonApiService _apiService = DummyJsonApiService();
//   List<dynamic> _products = [];
//   int _page = 1;
//   final TextEditingController _searchController = TextEditingController();
//   final RefreshController _refreshController = RefreshController(
//     initialRefresh: false,
//   );
//
//   Future<void> _loadData() async {
//     try {
//       List<dynamic> products = await _apiService.fetchProducts(page: _page);
//       setState(() {
//         _products.addAll(products);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _onRefresh() async {
//     _page = 1;
//     _products.clear();
//     await _loadData();
//     _refreshController.refreshCompleted();
//   }
//
//   Future<void> _searchProduct(String query) async {
//     try {
//       List<dynamic> products = await _apiService.searchProducts(query);
//       setState(() {
//         _products = products;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DummyJson Api'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(context: context, delegate: ProductSearchDelegate());
//             },
//             icon: const Icon(Icons.search),
//           )
//         ],
//       ),
//       body: SmartRefresher(
//         controller: _refreshController,
//         onRefresh: _onRefresh,
//         enablePullUp: true,
//         child: ListView.builder(
//           itemCount: _products.length,
//           itemBuilder: (context, index) {
//             var product = _products[index];
//             return Card(
//               child: ListTile(
//                 leading: Text(product['title'] ?? 'No title'),
//                 title: Text('\$${product['price'] ?? 0.0}'),
//                 trailing: CachedNetworkImage(
//                   imageUrl: product['thumbnail'] ?? '',
//                   placeholder: (context, url) =>
//                       const CircularProgressIndicator(),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class ProductSearchDelegate extends SearchDelegate {
//   final DummyJsonApiService _apiService = DummyJsonApiService();
//
//   @override
//   // TODO: implement searchFieldLabel
//   String? get searchFieldLabel => 'Search Products';
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       )
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder<List<dynamic>>(
//       future: _apiService.searchProducts(query),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         if (snapshot.hasError) {
//           return Center(
//             child: Text('error: ${snapshot.error.toString()}'),
//           );
//         }
//
//         final products = snapshot.data ?? [];
//
//         return ListView.builder(
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             var product = products[index];
//             return ListTile(
//               title: Text(product['title']),
//               subtitle: Text('\$${product['price']}'),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return const Center(child: Text('Enter product name'));
//   }
// }
