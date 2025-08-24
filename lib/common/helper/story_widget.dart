import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String image;
  final VoidCallback ontap;

  const StoryWidget({super.key, required this.image, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: const Color.fromARGB(255, 80, 7, 7),
        child: CircleAvatar(
          radius: 29.0,
          backgroundImage: NetworkImage(image),
        ),
      ),
    );
  }
}