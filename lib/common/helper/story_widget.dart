import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String image;

  const StoryWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: AssetImage(image),
    );
  }
}