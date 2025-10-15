import 'package:metro_quest/domain/entities/fact_entity.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/stations_repository.dart';

class GetFilteredStationsUseCase {
  final StationRepository repository;

  GetFilteredStationsUseCase({required this.repository});

  Future<List<Station>> execute({
    String? lineId,
    String? lineName,
    String? id,
    String? name,
    String? city,
    String? nomCommune,
    Fact? funFact,
    Fact? historyFact,
  }) async {
    final stations = await repository.getAllStations();

    return stations.where((station) {
      if (lineId != null && station.lineId != lineId) return false;
      if (lineName != null && station.lineName != lineName) return false;
      if (id != null && station.id != id) return false;
      if (name != null && station.name != name) return false;
      if (city != null && station.city != city) return false;
      if (funFact != null && station.funFact != funFact) return false;
      if (historyFact != null && station.historyFact != historyFact) return false;
      return true;
    }).toList();
  }
}
