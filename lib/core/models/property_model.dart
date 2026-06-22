class PropertyModel {
  final String id;
  final String title;
  final String type;
  final String location;
  final double price;
  final String description;
  final int beds;
  final int baths;
  final String area;
  final String imageUrl;

  PropertyModel({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.price,
    required this.description,
    required this.beds,
    required this.baths,
    required this.area,
    required this.imageUrl,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PropertyModel(
      id: documentId,
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      location: data['location'] ?? '',
      price: (data['price'] as num).toDouble(),
      description: data['description'] ?? '',
      beds: (data['beds'] as num).toInt(),
      baths: (data['baths'] as num).toInt(),
      area: data['area'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'title': title,
      'type': type,
      'location': location,
      'price': price,
      'description': description,
      'beds': beds,
      'baths': baths,
      'area': area,
      'imageUrl': imageUrl,
    };
  }
}
