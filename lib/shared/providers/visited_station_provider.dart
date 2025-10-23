import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/services/database/visited_station_service.dart';

final visitedStationServiceProvider = Provider<VisitedStationService>((ref) {
  final service = VisitedStationService();
  service.init();
  return service;
});
