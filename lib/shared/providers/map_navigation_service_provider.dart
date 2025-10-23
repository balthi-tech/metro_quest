import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/services/map/map_navigation_service.dart';

final mapNavigationServiceProvider = Provider<MapNavigationService>((ref) {
  return MapNavigationService();
});
