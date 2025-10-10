import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/station_repository.dart';

class GetFilteredStationsUseCase {
  final StationRepository repository;

  GetFilteredStationsUseCase({required this.repository});

  Future<List<Station>> execute({
    String? routeId,
    String? routeLongName,
    String? stopId,
    String? stopName,
    String? operatorName,
    String? nomCommune,
    String? codeInsee,
    String? funfact,
    String? histoire,
    bool? visited,
  }) async {
    final stations = await repository.getAllStations();

    return stations.where((station) {
      if (routeId != null && station.routeId != routeId) return false;
      if (routeLongName != null && station.routeLongName != routeLongName) return false;
      if (stopId != null && station.stopId != stopId) return false;
      if (stopName != null && station.stopName != stopName) return false;
      if (operatorName != null && station.operatorName != operatorName) return false;
      if (nomCommune != null && station.nomCommune != nomCommune) return false;
      if (codeInsee != null && station.codeInsee != codeInsee) return false;
      if (funfact != null && station.funfact != funfact) return false;
      if (histoire != null && station.histoire != histoire) return false;
      if (visited != null && station.visited != visited) return false;
      return true;
    }).toList();
  }
}
