import 'package:metro_quest/domain/entities/metro_station_entity.dart';

abstract class StationRepository {
  Future<List<MetroStation>> getAllStations();
}
