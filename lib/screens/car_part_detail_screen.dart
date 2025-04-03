import 'package:flutter/material.dart';
import '../models/car_part.dart';
import '../widgets/car_part_image.dart';

class CarPartDetailScreen extends StatelessWidget {
  final CarPart part;

  const CarPartDetailScreen({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(part.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CarPartImage(
                      imageUrl: part.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    part.name,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: \$${part.price.toStringAsFixed(2)}",
                    style:
                        const TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    part.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
