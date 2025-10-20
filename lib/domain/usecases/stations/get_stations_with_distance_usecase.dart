import 'package:metro_quest/core/utils/distance_calculator.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class GetStationsWithDistanceUseCase {
  GetStationsWithDistanceUseCase();

  Future<List<MetroStation>> execute({
    required List<MetroStation> stations,
    required GeoPoint currentPosition,
  }) async {
    return stations.map((station) {
      final distance = DistanceCalculator.calculateDistance(currentPosition, station.geoPoint);
      return station.copyWith(distanceFromUser: distance);
    }).toList()..sort((a, b) => a.distanceFromUser!.compareTo(b.distanceFromUser!));
  }
}
