import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class ActiveNavigationNotifier extends Notifier<MetroStation?> {
  @override
  MetroStation? build() => null;

  void startNavigationTo(MetroStation station) => state = station;

  void stopNavigation() => state = null;
}
