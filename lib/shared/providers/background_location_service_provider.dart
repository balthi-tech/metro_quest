import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/services/location/background_location_service.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/features/active_navigation/logic/active_navigation_provider.dart';
import 'package:metro_quest/shared/providers/local_notification_service_provider.dart';

final backgroundLocationServiceProvider = Provider<BackgroundLocationService>((ref) {
  final notificationService = ref.read(notificationServiceProvider);

  final service = BackgroundLocationService(notificationService: notificationService);
  service.init();
  ref.listen<MetroStation?>(activeNavigationProvider, (previous, next) {
    service.setTargetStation(next);
  });
  return service;
});
