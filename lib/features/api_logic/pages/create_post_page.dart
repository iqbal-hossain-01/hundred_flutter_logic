import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/api_logic/services/api_service.dart';

class CreatePostPage extends StatelessWidget {
  static const String routeName = '/createPost';

  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Put Delete')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final post = await ApiService()
                      .createPost('New Post', 'My first post');
                  print('post create: $post');
                } catch (e) {
                  print('error: $e');
                }
              },
              child: const Text('Create Post'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final post = await ApiService().updatePost(
                    1,
                    'New post 2',
                    'My first update post',
                  );
                  print('updated post: $post');
                } catch (e) {
                  print('error: $e');
                }
              },
              child: const Text('Update Post'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ApiService().deletePost(1);
                } catch (e){
                  print('error: $e');
                }
              },
              child: const Text('Deleted post'),
            ),
          ],
        ),
      ),
    );
  }
}
