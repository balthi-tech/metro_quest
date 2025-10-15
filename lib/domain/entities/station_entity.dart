import 'package:metro_quest/domain/entities/fact_entity.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class Station {
  final String id;
  final String name;
  final GeoPoint geoPoint;
  final String lineId;
  final String lineName;
  final String city;
  final Fact? funFact;
  final Fact? historyFact;

  Station({
    required this.id,
    required this.name,
    required this.geoPoint,
    required this.lineId,
    required this.lineName,
    required this.city,
    this.funFact,
    this.historyFact,
  });
}
