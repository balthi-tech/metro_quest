import 'dart:math';

import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class SelectRandomStationUseCase {
  final Random random;

  SelectRandomStationUseCase({required this.random});

  final Map<double, bool Function(double)> distanceFilters = {
    0.7: (distance) => distance <= 3.0,
    0.9: (distance) => distance > 3.0 && distance <= 8.0,
    1.0: (distance) => distance > 8.0 && distance <= 20.0,
  };

  MetroStation? execute(List<MetroStation> stations) {
    if (stations.isEmpty) {
      return null;
    }

    final randomValue = random.nextDouble();

    List<MetroStation> filteredStations = [];
    for (final entry in distanceFilters.entries) {
      if (randomValue <= entry.key) {
        filteredStations = stations.where((station) {
          final distance = station.distanceFromUser ?? double.infinity;
          return entry.value(distance);
        }).toList();
        break;
      }
    }

    if (filteredStations.isEmpty) {
      filteredStations = stations;
    }

    final selectedStation = filteredStations[random.nextInt(filteredStations.length)];

    return selectedStation;
  }
}
