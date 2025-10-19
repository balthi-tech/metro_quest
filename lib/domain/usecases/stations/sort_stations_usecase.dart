import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';

class SortedStationsUseCase {
  SortedStationsUseCase();

  List<MetroStation> execute({
    required List<MetroStation> metroStations,
    MetroStationSortCriteria? criteria,
    GeoPoint? userLocation,
  }) {
    if (criteria == null) {
      return metroStations;
    }

    metroStations.sort((a, b) {
      switch (criteria) {
        case MetroStationSortCriteria.nameAsc:
          return a.name.compareTo(b.name);
        case MetroStationSortCriteria.nameDesc:
          return b.name.compareTo(a.name);
        case MetroStationSortCriteria.idAsc:
          return a.id.compareTo(b.id);
        case MetroStationSortCriteria.idDesc:
          return b.id.compareTo(a.id);
        case MetroStationSortCriteria.distanceAsc:
          if (a.distanceFromUser == null || b.distanceFromUser == null) {
            return 0;
          }

          return a.distanceFromUser!.compareTo(b.distanceFromUser!);

        case MetroStationSortCriteria.distanceDesc:
          if (a.distanceFromUser == null || b.distanceFromUser == null) {
            return 0;
          }

          return b.distanceFromUser!.compareTo(a.distanceFromUser!);
      }
    });

    return metroStations;
  }
}
