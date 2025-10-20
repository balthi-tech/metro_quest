import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';
import 'package:metro_quest/shared/widgets/metro_filter_button.dart';
import 'package:metro_quest/shared/widgets/metro_station_list_tile.dart';

class AllStationsPage extends ConsumerStatefulWidget {
  const AllStationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllStationsPageState();
}

class _AllStationsPageState extends ConsumerState<AllStationsPage> {
  MetroStationSortCriteria _selectedCriteria = MetroStationSortCriteria.distanceAsc;

  @override
  Widget build(BuildContext context) {
    final asyncStations = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(
          sortBy: _selectedCriteria,
        ),
      ),
    );

    final stationController = ref.read(stationControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stations de métro'),
        actions: [
          MetroFilterButton<MetroStationSortCriteria>(
            values: MetroStationSortCriteria.values,
            initialCriteria: _selectedCriteria,
            onCriteriaSelected: (criteria) {
              setState(() {
                _selectedCriteria = criteria;
              });
            },
          ),
        ],
      ),
      body: asyncValueWrapper(
        asyncValue: asyncStations,
        data: (stations) => ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];

            return MetroStationListTile(station: station, stationController: stationController, isReadOnly: true);
          },
        ),
      ),
    );
  }
}
