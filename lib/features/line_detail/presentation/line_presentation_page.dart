import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';
import 'package:metro_quest/features/station/logic/station_controller.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';
import 'package:metro_quest/shared/widgets/metro_filter_button.dart';
import 'package:metro_quest/shared/widgets/metro_station_list_tile.dart';

class LinePresentationPage extends ConsumerStatefulWidget {
  final String lineId;
  const LinePresentationPage({super.key, required this.lineId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinePresentationPageState();
}

class _LinePresentationPageState extends ConsumerState<LinePresentationPage> {
  MetroStationSortCriteria _selectedCriteria = MetroStationSortCriteria.distanceAsc;

  @override
  Widget build(BuildContext context) {
    final lineId = widget.lineId;

    final stationProvider = stationControllerProvider;

    final filteredStationsAsync = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(lineId: lineId, sortBy: _selectedCriteria),
      ),
    );

    final stationController = ref.read(stationProvider.notifier);

    final linesAsync = ref.watch(lineControllerProvider);
    final currentLine = linesAsync.value?.firstWhereOrNull(
      (line) => line.id == lineId,
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: currentLine?.color ?? Theme.of(context).primaryColor,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Stations de la ligne ${currentLine?.name ?? ''}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          MetroFilterButton<MetroStationSortCriteria>(
            values: MetroStationSortCriteria.values,
            initialCriteria: _selectedCriteria,
            onCriteriaSelected: (criteria) {
              setState(() {
                _selectedCriteria = criteria;
              });
            },
            color: Colors.white,
          ),
        ],
      ),
      body: asyncValueWrapper(
        asyncValue: filteredStationsAsync,
        loading: () => const Center(child: Text('Chargement des stations...')),
        data: (stations) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                color: currentLine?.color ?? Colors.grey,
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    Text(
                      "Nombre de stations visitées: ${stations.where((station) => station.visited).length} / ${stations.length}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Accomplissement de la ligne: ${stations.isNotEmpty ? ((stations.where((station) => station.visited).length / stations.length) * 100).toStringAsFixed(0) : '0'}%",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: _buildStationList(
                  stations,
                  stationController,
                  currentLine,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStationList(
    List<MetroStation> stations,
    StationController stationController,
    dynamic currentLine,
  ) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return MetroStationListTile(
          station: station,
          stationController: stationController,
          isCheckable: true,
        );
      },
    );
  }
}
