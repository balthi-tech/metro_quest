import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:metro_quest/core/services/notification/local_notification_service.dart';
import 'package:metro_quest/core/utils/distance_calculator.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/notification_payload.dart';

class BackgroundLocationService {
  final NotificationService notificationService;
  BackgroundLocationService({required this.notificationService});

  // BackgroundLocationService();

  MetroStation? _targetStation;
  bool _notified = false;

  void setTargetStation(MetroStation? station) {
    _targetStation = station;
    _notified = false; // reset notification flag when station changes
  }

  void init() {
    // Listen to location updates
    bg.BackgroundGeolocation.onLocation(_onLocation, (bg.LocationError error) {
      Log.e('[location] ERROR: $error');
    });

    // Configure BackgroundGeolocation plugin
    bg.BackgroundGeolocation.ready(
      bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10,
        stopOnTerminate: false,
        startOnBoot: true,
      ),
    ).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  void _onLocation(bg.Location location) {
    if (_targetStation == null) {
      Log.d('No target station set.');
      return;
    }

    Log.d('Received location update: ${location.coords.latitude}, ${location.coords.longitude}');

    final lat = location.coords.latitude;
    final lon = location.coords.longitude;

    final distance = DistanceCalculator.calculateDistance(
      GeoPoint(latitude: lat, longitude: lon),
      _targetStation!.geoPoint,
    );

    Log.d('Distance to target station: $distance km');

    final bool needsNotification = distance <= 0.1 && !_notified;

    Log.d('Needs notification: $needsNotification');

    if (needsNotification) {
      // threshold 100 meters
      _notified = true;

      Log.d('User is within 100 meters of station ${_targetStation!.name}');

      notificationService.showNotification(
        title: 'Proche de la station ${_targetStation!.name}',
        body: 'Revenez à Metro Discover',
        payload: ProximityNotificationPayload(stationId: _targetStation!.id),
      );
    }
  }
}
