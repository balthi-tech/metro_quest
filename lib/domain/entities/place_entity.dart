import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class Place {
  final String id;
  final String name;
  final String address;
  final GeoPoint location;

  final List<String> categories;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.categories,
  });

  // toString method for debugging
  @override
  String toString() {
    return 'Place{id: $id, name: $name, address: $address, location: $location, categories: $categories}';
  }
}
