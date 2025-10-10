import 'package:metro_quest/domain/entities/station_entity.dart';

abstract class StationRepository {
  Future<List<Station>> getAllStations();
}
