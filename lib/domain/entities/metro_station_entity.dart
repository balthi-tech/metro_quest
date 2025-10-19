import 'package:metro_quest/domain/entities/fact_entity.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class MetroStation {
  final String id;
  final String name;
  final GeoPoint geoPoint;
  final String lineId;
  final String lineName;
  final String city;
  final Fact? funFact;
  final Fact? historyFact;
  final bool visited;
  final double? distanceFromUser;

  MetroStation({
    required this.id,
    required this.name,
    required this.geoPoint,
    required this.lineId,
    required this.lineName,
    required this.city,
    this.funFact,
    this.historyFact,
    this.visited = false,
    this.distanceFromUser,
  });

  @override
  String toString() {
    return 'MetroStation(id: $id, name: $name, geoPoint: $geoPoint, lineId: $lineId, lineName: $lineName, city: $city, funFact: $funFact, historyFact: $historyFact, visited: $visited)';
  }

  MetroStation copyWith({bool? visited, double? distanceFromUser}) {
    return MetroStation(
      id: id,
      name: name,
      lineName: lineName,
      geoPoint: geoPoint,
      visited: visited ?? this.visited,
      lineId: lineId,
      city: city,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }
}
