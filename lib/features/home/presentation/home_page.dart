import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';
import 'package:metro_quest/features/metro_map/presentation/map.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final asyncStations = ref.watch(stationControllerProvider);

    final filteredStationsAsync = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(
          sortBy: MetroStationSortCriteria.distanceAsc,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Liste des stations')),
      body: asyncValueWrapper(
        asyncValue: filteredStationsAsync,
        data: (stations) => _buildData(stations),
      ),
    );
  }

  Widget _buildData(List<MetroStation> stations) {
    return Column(
      children: [
        Expanded(
          child: MetroMap(
            stations: stations,
          ),
        ),
      ],
    );
  }
}
