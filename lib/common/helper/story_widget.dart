import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String image;

  const StoryWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: const Color.fromARGB(255, 80, 7, 7),
      child: CircleAvatar(
        radius: 29.0,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}