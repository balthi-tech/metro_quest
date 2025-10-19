import 'package:metro_quest/core/utils/distance_calculator.dart';
import 'package:metro_quest/core/utils/location_service.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class GetStationsWithDistanceUseCase {
  final LocationService _locationService;

  GetStationsWithDistanceUseCase(this._locationService);

  Future<List<MetroStation>> execute(List<MetroStation> stations) async {
    final currentPosition = await _locationService.getCurrentPosition();

    return stations.map((station) {
      final distance = DistanceCalculator.calculateDistance(currentPosition, station.geoPoint);
      return station.copyWith(distanceFromUser: distance);
    }).toList()..sort((a, b) => a.distanceFromUser!.compareTo(b.distanceFromUser!));
  }
}
