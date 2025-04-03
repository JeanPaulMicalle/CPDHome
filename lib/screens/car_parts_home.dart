import 'package:flutter/material.dart';
import '../models/car_part.dart';
import 'car_part_detail_screen.dart';
import 'add_part_screen.dart';
import '../widgets/car_part_image.dart';

class CarPartsHome extends StatefulWidget {
  const CarPartsHome({super.key});

  @override
  State<CarPartsHome> createState() => _CarPartsHomeState();
}

class _CarPartsHomeState extends State<CarPartsHome> {
  // Temporary items for testing
  final List<CarPart> parts = [
    CarPart(
      name: 'Engine',
      description:
          'High performance V8 engine with advanced technology for optimized power and efficiency.',
      price: 2500.00,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlZXvJRvfbwnA-MTgDZO1d8VLUAaiaj6h12g&s',
    ),
    CarPart(
      name: 'Tire',
      description:
          'All-weather tire designed for excellent grip and durability in diverse conditions.',
      price: 150.00,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlZXvJRvfbwnA-MTgDZO1d8VLUAaiaj6h12g&s',
    ),
    CarPart(
      name: 'Brake Pad',
      description:
          'Durable brake pad engineered for enhanced safety and longevity under high-stress conditions.',
      price: 75.00,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlZXvJRvfbwnA-MTgDZO1d8VLUAaiaj6h12g&s',
    ),
  ];

  // Function to add a new part to the list.
  void _addNewPart(CarPart newPart) {
    setState(() {
      parts.add(newPart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Parts Catalog'),
      ),
      body: ListView.builder(
        itemCount: parts.length,
        itemBuilder: (context, index) {
          final part = parts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CarPartImage(
                  imageUrl: part.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                part.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                "Price: \$${part.price.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.black87),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarPartDetailScreen(part: part),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the add part screen and await the result.
          final newPart = await Navigator.push<CarPart>(
            context,
            MaterialPageRoute(builder: (context) => const AddPartScreen()),
          );
          if (newPart != null) {
            _addNewPart(newPart);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
