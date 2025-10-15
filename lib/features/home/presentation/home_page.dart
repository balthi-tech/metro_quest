import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/features/metro_map/presentation/map.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStations = ref.watch(stationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Liste des stations')),
      body: asyncStations.when(
        data: (stations) => _buildData(stations),
        loading: () => _buildLoading(),
        error: (error, _) => _buildError(error),
      ),
    );
  }

  Widget _buildData(List<Station> stations) {
    return Column(
      children: [
        Expanded(
          child: MetroMap(
            stations: stations,
          ),
        ),
      ],
    );
    // return ListView.builder(
    //   itemCount: stations.length,
    //   itemBuilder: (context, index) {
    //     final station = stations[index];
    //     return ListTile(
    //       title: Text(station.stopName),
    //       subtitle: Text(station.routeLongName),
    //     );
    //   },
    // );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: Text('Erreur: $error'),
    );
  }
}
