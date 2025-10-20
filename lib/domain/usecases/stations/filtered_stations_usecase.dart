import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';

class FilteredStationsUseCase {
  FilteredStationsUseCase();

  List<MetroStation> execute({
    required List<MetroStation> metroStations,
    MetroStationFilterCriterias? criteria,
  }) {
    return metroStations.where((station) {
      if (criteria?.lineId != null && station.lineId != criteria?.lineId) {
        return false;
      }
      if (criteria?.lineName != null && station.lineName != criteria?.lineName) {
        return false;
      }
      if (criteria?.id != null && station.id != criteria?.id) {
        return false;
      }
      if (criteria?.name != null && station.name != criteria?.name) {
        return false;
      }
      if (criteria?.city != null && station.city != criteria?.city) {
        return false;
      }
      if (criteria?.funFact != null && station.funFact != criteria?.funFact) {
        return false;
      }
      if (criteria?.historyFact != null && station.historyFact != criteria?.historyFact) {
        return false;
      }
      if (criteria?.visited != null && station.visited != criteria?.visited) {
        return false;
      }
      return true;
    }).toList();
  }
}
