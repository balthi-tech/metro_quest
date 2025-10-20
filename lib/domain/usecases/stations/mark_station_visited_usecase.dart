import 'package:metro_quest/core/services/visited_station_service.dart';

class MarkStationVisitedUseCase {
  final VisitedStationService _service;

  MarkStationVisitedUseCase(this._service);

  Future<void> execute(String stationId) async {
    await _service.markVisited(stationId);
  }

  Future<void> unexecute(String stationId) async {
    await _service.unmarkVisited(stationId);
  }
}
