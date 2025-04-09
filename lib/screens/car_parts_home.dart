import 'package:flutter/material.dart';
import 'package:jean_paul_micallef_swd62a/services/notification_service.dart';
import '../models/car_part.dart';
import 'car_part_detail_screen.dart';
import 'add_part_screen.dart';
import '../widgets/car_part_image.dart';
import '../services/car_part_api_service.dart';

class CarPartsHome extends StatefulWidget {
  const CarPartsHome({super.key});

  @override
  State<CarPartsHome> createState() => _CarPartsHomeState();
}

class _CarPartsHomeState extends State<CarPartsHome> {
  final CarPartApiService apiService = CarPartApiService();
  List<CarPart> parts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadParts();
  }

  Future<void> _loadParts() async {
    try {
      final fetchedParts = await apiService.fetchCarParts();
      setState(() {
        parts = fetchedParts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to load parts')));
    }
  }

  Future<void> _addNewPart() async {
  final newPart = await Navigator.push<CarPart>(
    context,
    MaterialPageRoute(builder: (context) => const AddPartScreen()),
  );
  if (newPart != null) {
    try {
      // Add the part to the API.
      final addedPart = await apiService.addCarPart(newPart);
      setState(() {
        parts.add(addedPart);
      });
      // Triger a notification indicating the part was added.
      await NotificationService.showNotification(
        title: 'New Car Part Added',
        body: '${addedPart.name} was successfully added to your catalog.',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add new part')));
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Parts Catalog'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: parts.length,
              itemBuilder: (context, index) {
                final part = parts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
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
                          builder: (context) =>
                              CarPartDetailScreen(part: part),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPart,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}