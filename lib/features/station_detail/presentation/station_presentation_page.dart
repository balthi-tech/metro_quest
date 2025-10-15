import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';

class StationDetailPage extends ConsumerStatefulWidget {
  final String stationId;
  const StationDetailPage({required this.stationId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends ConsumerState<StationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final station = ref
        .watch(stationControllerProvider)
        .value
        ?.firstWhereOrNull((station) => station.id == widget.stationId);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
        ),
        title: Text(station?.name ?? 'Détails de la station'),
      ),
      body: station == null
          ? Center(child: Text('Station non trouvée'))
          : Padding(
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
            ),
    );
  }
}
