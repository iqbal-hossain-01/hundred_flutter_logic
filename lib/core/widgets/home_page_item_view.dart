import 'package:flutter/material.dart';

class HomePageItemView extends StatelessWidget {
  final VoidCallback routeName;
  final String title;

  const HomePageItemView(
      {super.key, required this.routeName, required this.title,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: InkWell(
          onTap: routeName,
          child: Center(
            child: ListTile(
                title: Text(
                  title,
                  selectionColor: Colors.blue,
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: const Icon(Icons.run_circle_outlined, size: 30)
            ),
          ),
        ),
      ),
    );
  }
}
