import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';

class StationDetailPage extends ConsumerStatefulWidget {
  final String stationId;
  const StationDetailPage({required this.stationId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends ConsumerState<StationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final filteredStationAsync = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(id: widget.stationId),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
        ),
        title: Text('Détails de la station'),
      ),
      body: asyncValueWrapper(
        asyncValue: filteredStationAsync,
        data: (stations) {
          if (stations.isEmpty) {
            return Center(child: Text('Station non trouvée'));
          }

          final station = stations.first;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                Text('ID de la station: ${station.id}'),
                SizedBox(height: 8),
                Text('Nom de la ligne: ${station.lineName}'),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
