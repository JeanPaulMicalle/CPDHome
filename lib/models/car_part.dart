class CarPart {
  final String id; 
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  CarPart({
    this.id = '',
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory CarPart.fromJson(Map<String, dynamic> json) {
    return CarPart(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
    );
  }

  // Convert CarPart to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
