import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/repositories/stations_repository.dart';

class GetStationsUseCase {
  final StationRepository repository;

  GetStationsUseCase({required this.repository});

  Future<List<MetroStation>> execute() async {
    return await repository.getAllStations();
  }
}
