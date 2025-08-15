import 'package:flutter/material.dart';

class DynamicStarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color filledColor;
  final Color emptyColor;

  const DynamicStarRating({
    super.key,
    required this.rating,
    this.starSize = 20.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    const int maxStars = 5;
    List<Widget> stars = [];

    // Ensure rating is non-negative and within bounds
    double clampedRating = rating.clamp(0.0, maxStars.toDouble());

    // Calculate filled stars
    int filledStars = clampedRating.floor();

    // Check for half star
    bool hasHalfStar = (clampedRating - filledStars) >= 0.5;

    // Calculate empty stars
    int emptyStars = maxStars - filledStars - (hasHalfStar ? 1 : 0);

    // Add filled stars
    for (int i = 0; i < filledStars; i++) {
      stars.add(Icon(
        Icons.star,
        color: filledColor,
        size: starSize,
      ));
    }

    // Add half star if applicable
    if (hasHalfStar) {
      stars.add(Icon(
        Icons.star_half,
        color: filledColor,
        size: starSize,
      ));
    }

    // Add empty stars
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(
        Icons.star_border,
        color: emptyColor,
        size: starSize,
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}