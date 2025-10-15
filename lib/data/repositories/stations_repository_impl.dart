import 'package:metro_quest/data/sources/stations_datasource.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/stations_repository.dart';

class StationRepositoryImpl implements StationRepository {
  final StationDataSource stationDataSource;

  StationRepositoryImpl({required this.stationDataSource});

  @override
  Future<List<Station>> getAllStations() async {
    final dtos = await stationDataSource.fetchStationDTOs();

    final funFactsMap = await stationDataSource.fetchFunFacts();
    final historyFactsMap = await stationDataSource.fetchHistoryFacts();

    print('Fetched ${dtos.length} stations');

    final stations = dtos.map((dto) {
      final funFact = funFactsMap[dto.stopId];
      final historyFact = historyFactsMap[dto.stopId];
      return dto.toDomain(
        funfact: funFact,
        historyFact: historyFact,
      );
    }).toList();
    return stations;
  }
}
