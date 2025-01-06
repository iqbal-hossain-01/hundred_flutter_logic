import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/api_logic/services/api_service.dart';

class PaginationPage extends StatefulWidget {
  static const String routeName = '/pagination';
  const PaginationPage({super.key});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  final ApiService apiService = ApiService();
  List<dynamic> posts = [];
  int currentPage = 1;
  final int limit = 10;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchPost() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newPosts = await apiService.fetchPaginationPost(currentPage, limit);
      setState(() {
        currentPage++;
        if (newPosts.length < limit) {
          hasMore = false;
        }
        posts.addAll(newPosts);
      });
    } catch (e) {
      print('error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paginated Page')),
      body: ListView.builder(
        itemCount: posts.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == posts.length) {
            if (!isLoading) fetchPost();
            return const Center(child: CircularProgressIndicator(),);
          }
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('${post['userId']}+${post['id']}'),
                title: Text(post['title']),
                subtitle: Text(post['body']),
              ),
            ),
          );
        },
      ),
    );
  }
}
