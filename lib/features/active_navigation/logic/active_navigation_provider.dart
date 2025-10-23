import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/features/active_navigation/logic/active_navigation_controller.dart';

final activeNavigationProvider = NotifierProvider<ActiveNavigationNotifier, MetroStation?>(() {
  return ActiveNavigationNotifier();
});
