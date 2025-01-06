import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/api_logic/services/api_service.dart';

class ApiShowResultPage extends StatefulWidget {
  static const String routeName = '/apiShowResult';

  const ApiShowResultPage({super.key});

  @override
  State<ApiShowResultPage> createState() => _ApiShowResultPageState();
}

class _ApiShowResultPageState extends State<ApiShowResultPage> {
  late Future<List<dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = ApiService().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Operation'),
      ),
      body: FutureBuilder(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error ${snapshot.error.toString()}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Text('${post['id']}'),
                    title: Text(post['title']),
                    subtitle: Text(post['body']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
