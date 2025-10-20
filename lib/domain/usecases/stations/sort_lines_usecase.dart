import 'package:metro_quest/core/utils/compare_metro_line_name.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_sort_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class SortedLinesUseCase {
  SortedLinesUseCase();

  // for each line, find the closest station and determine the order for display line according to distance from user

  List<MetroLine> _addDistancesToLines(
    List<MetroLine> metroLines,
    List<MetroStation> sortedStationsByDistance,
  ) {
    return metroLines.map((line) {
      final closestStation = _findClosestStation(line, sortedStationsByDistance);
      return line.copyWith(
        distanceFromUser: closestStation?.distanceFromUser,
      );
    }).toList();
  }

  MetroStation? _findClosestStation(MetroLine line, List<MetroStation> sortedStationsByDistance) {
    for (var station in sortedStationsByDistance) {
      if (station.lineId == line.id) {
        return station;
      }
    }
    return null;
  }

  List<MetroLine> execute({
    required List<MetroLine> metroLines,
    List<MetroStation>? sortedStationsByDistance,
    MetroLineSortCriteria? criteria,
  }) {
    if (sortedStationsByDistance != null) {
      metroLines = _addDistancesToLines(metroLines, sortedStationsByDistance);
    }

    if (criteria == null) {
      return metroLines;
    }

    metroLines.sort((a, b) {
      switch (criteria) {
        case MetroLineSortCriteria.nameAsc:
          return compareMetroLineNames(a.name, b.name);
        case MetroLineSortCriteria.nameDesc:
          return compareMetroLineNames(b.name, a.name);
        case MetroLineSortCriteria.idAsc:
          return a.id.compareTo(b.id);
        case MetroLineSortCriteria.idDesc:
          return b.id.compareTo(a.id);
        case MetroLineSortCriteria.distanceAsc:
          if (a.distanceFromUser == null || b.distanceFromUser == null) {
            return 0;
          }
          return a.distanceFromUser!.compareTo(b.distanceFromUser!);
        case MetroLineSortCriteria.distanceDesc:
          if (a.distanceFromUser == null || b.distanceFromUser == null) {
            return 0;
          }
          return b.distanceFromUser!.compareTo(a.distanceFromUser!);
      }
    });

    return metroLines;
  }
}
