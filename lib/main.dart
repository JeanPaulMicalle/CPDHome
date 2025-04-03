import 'package:flutter/material.dart';
import 'screens/car_parts_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Parts Catalog',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal[50],
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.amber),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CarPartsHome(),
    );
  }
}
