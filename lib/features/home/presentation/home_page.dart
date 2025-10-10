import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStations = ref.watch(stationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Liste des stations')),
      body: asyncStations.when(
        data: (stations) => ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            return ListTile(
              title: Text(station.stopName),
              subtitle: Text(station.routeLongName),
            );
          },
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, _) => Center(
          child: Text('Erreur: $error'),
        ),
      ),
    );
  }
}
