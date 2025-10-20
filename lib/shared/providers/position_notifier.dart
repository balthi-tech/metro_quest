import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class PositionNotifier extends AsyncNotifier<GeoPoint?> {
  StreamSubscription<Position>? _subscription;

  @override
  FutureOr<GeoPoint?> build() {
    // Démarre l’écoute GPS dès l’initialisation
    _startListening();

    // Annule l’abonnement automatiquement lors de la destruction du provider
    ref.onDispose(() {
      _subscription?.cancel();
    });

    // Valeur initiale (position non encore connue)
    return null;
  }

  void _startListening() {
    final settings = const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 50,
    );

    _subscription = Geolocator.getPositionStream(locationSettings: settings).listen(
      (position) {
        if (kDebugMode) {
          print('New position: ${position.latitude}, ${position.longitude}');
        }
        final point = GeoPoint(latitude: position.latitude, longitude: position.longitude);
        state = AsyncData(point);
      },
      onError: (error, stackTrace) {
        // Ici on peut choisir : null ou erreur explicite
        state = AsyncData(null);
        // Ou pour montrer l’erreur explicitement :
        // state = AsyncError(error, stackTrace);
      },
    );
  }
}
