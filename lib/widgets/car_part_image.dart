import 'dart:io';
import 'package:flutter/material.dart';

class CarPartImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CarPartImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('http')) {
      // Display image from the network.
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      // Display image from a local file.
      return Image.file(
        File(imageUrl),
        width: width,
        height: height,
        fit: fit,
      );
    }
  }
}
