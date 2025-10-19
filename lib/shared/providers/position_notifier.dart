import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class PositionNotifier extends AsyncNotifier<GeoPoint?> {
  StreamSubscription<Position>? _subscription;

  @override
  FutureOr<GeoPoint?> build() {
    // Démarre l'écoute GPS dès que le provider est initialisé
    _startListening();

    // Annule l’abonnement automatiquement à la destruction du provider
    ref.onDispose(() {
      _subscription?.cancel();
    });

    return null;
  }

  void _startListening() {
    final settings = const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 20,
    );

    _subscription = Geolocator.getPositionStream(locationSettings: settings).listen(
      (position) {
        final point = GeoPoint(latitude: position.latitude, longitude: position.longitude);
        state = AsyncData(point);
      },
      onError: (err) {
        state = AsyncError(err, StackTrace.current);
      },
    );
  }
}
