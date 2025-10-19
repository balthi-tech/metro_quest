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

class LinePresentationPage extends ConsumerStatefulWidget {
  final String lineId;
  const LinePresentationPage({super.key, required this.lineId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinePresentationPageState();
}

class _LinePresentationPageState extends ConsumerState<LinePresentationPage> {
  @override
  Widget build(BuildContext context) {
    final lineId = widget.lineId;

    final stationProvider = stationControllerProvider;

    final filteredStationsAsync = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(lineId: lineId, sortBy: MetroStationSortCriteria.distanceAsc),
      ),
    );

    final stationController = ref.read(stationProvider.notifier);

    final linesAsync = ref.watch(lineControllerProvider);
    final currentLine = linesAsync.value?.firstWhereOrNull(
      (line) => line.id == lineId,
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go('/lines');
          },
        ),
        title: Text(currentLine?.name ?? 'Détails de la ligne'),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Stations de la ligne ${currentLine?.name ?? ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
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
        return ListTile(
          title: Text(station.name),
          subtitle: Text(
            'Distance: ${station.distanceFromUser != null ? '${station.distanceFromUser!.toStringAsFixed(2)} km' : 'Inconnue'}',
          ),
          leading: CircleAvatar(
            backgroundColor: currentLine?.color ?? Colors.grey,
            child: Text(
              currentLine?.name.substring(0, 1) ?? '?',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          trailing: Checkbox(
            value: station.visited,
            onChanged: (value) async {
              await stationController.visitStation(station.id, value ?? false);
            },
          ),
          onTap: () {
            context.go('/station/${station.id}');
          },
        );
      },
    );
  }
}
