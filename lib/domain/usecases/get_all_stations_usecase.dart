import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/station_repository.dart';

class GetStationsUseCase {
  final StationRepository repository;

  GetStationsUseCase({required this.repository});

  Future<List<Station>> execute() async {
    return await repository.getAllStations();
  }
}
