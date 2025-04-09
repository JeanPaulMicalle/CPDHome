import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car_part.dart';

class CarPartApiService {
  static const String baseUrl = 'https://67eee10ac11d5ff4bf7b349d.mockapi.io/api/carparts';

  // Fetch the list of car parts from the API.
  Future<List<CarPart>> fetchCarParts() async {
  final response = await http.get(Uri.parse(baseUrl));
  
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((data) => CarPart.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load car parts');
  }
}

  // Add a new car part to the API.
  Future<CarPart> addCarPart(CarPart part) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(part.toJson()),
    );
    if (response.statusCode == 201) {
      return CarPart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add car part');
    }
  }
}
