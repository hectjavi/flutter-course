import 'package:flutter/material.dart';

class SocialWidget extends StatelessWidget {
  final Color color;
  final String imageAsset;
  const SocialWidget({
    super.key,
    required this.color,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imageAsset),
      ),
    );
  }
}
 