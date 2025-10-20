import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:metro_quest/core/utils/location_service.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/shared/providers/position_notifier.dart';

// final locationServiceProvider = Provider<LocationService>((ref) {
//   return LocationService();
// });

// final locationStreamServiceProvider = Provider<LocationStreamService>((ref) {
//   return LocationStreamService();
// });

// final userPositionStreamProvider = StreamProvider<GeoPoint>((ref) {
//   final service = ref.read(locationStreamServiceProvider);
//   return service.getPositionStream();
// });

final userPositionProvider = AsyncNotifierProvider<PositionNotifier, GeoPoint?>(() => PositionNotifier());
