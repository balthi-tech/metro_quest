import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:metro_quest/core/services/map/map_navigation_service.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/shared/providers/map_navigation_service_provider.dart';

class OpenInMapButton extends ConsumerStatefulWidget {
  final String destinationTitle;
  final GeoPoint geoPoint;
  final VoidCallback? onMapLaunched;

  const OpenInMapButton({super.key, required this.destinationTitle, required this.geoPoint, this.onMapLaunched});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpenInMapButtonState();
}

class _OpenInMapButtonState extends ConsumerState<OpenInMapButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: _openInMap, label: Text('Ouvrir dans Maps'), icon: Icon(Icons.map));
  }

  List<Widget> _buildMapOptions({
    required MapNavigationService mapNavigationService,
    required List<AvailableMap> maps,
  }) {
    return maps
        .map(
          (map) => ListTile(
            title: Text(map.mapName),
            onTap: () async {
              widget.onMapLaunched?.call();

              mapNavigationService.launchDirections(
                destinationTitle: widget.destinationTitle,
                map: map,
                geoPoint: widget.geoPoint,
              );

              Log.d('Lancement de la navigation vers ${widget.destinationTitle} dans ${map.mapName}');
              Navigator.of(context).pop();
            },
          ),
        )
        .toList();
  }

  void _openInMap() {
    final mapNavigationService = ref.read(mapNavigationServiceProvider);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          body: Column(
            children: [
              FutureBuilder<List<AvailableMap>>(
                future: mapNavigationService.getAvailableMaps(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur lors du chargement des applications de cartographie'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Aucune application de cartographie disponible'));
                  } else {
                    final maps = snapshot.data!;
                    return Expanded(
                      child: ListView(
                        children: _buildMapOptions(
                          mapNavigationService: mapNavigationService,
                          maps: maps,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
