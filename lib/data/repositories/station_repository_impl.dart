import 'package:metro_quest/data/sources/station_datasource.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/station_repository.dart';

class StationRepositoryImpl implements StationRepository {
  final StationDataSource dataSource;

  StationRepositoryImpl({required this.dataSource});

  @override
  Future<List<Station>> getAllStations() async {
    final dtos = await dataSource.fetchStationDTOs();
    final stations = dtos.map((dto) => dto.toDomain()).toList();
    return stations;
  }
}
