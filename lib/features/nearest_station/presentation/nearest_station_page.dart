import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';
import 'package:metro_quest/shared/widgets/metro_station_list_tile.dart';

class NearestStationPage extends ConsumerStatefulWidget {
  const NearestStationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NearestStationPageState();
}

class _NearestStationPageState extends ConsumerState<NearestStationPage> {
  @override
  Widget build(BuildContext context) {
    final asyncStations = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(
          sortBy: MetroStationSortCriteria.distanceAsc,
        ),
      ),
    );

    final stationController = ref.read(stationControllerProvider.notifier);

    // final linesAsync = ref.watch(lineControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stations les plus proches'),
      ),
      body: asyncValueWrapper(
        asyncValue: asyncStations,
        data: (stations) => ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];

            return MetroStationListTile(station: station, stationController: stationController, isCheckable: false);
          },
        ),
      ),
    );
  }
}
