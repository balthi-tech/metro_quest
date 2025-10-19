import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:metro_quest/core/extensions/geo_point_extension.dart';
import 'package:metro_quest/domain/entities/metro_line_segment_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';
import 'package:metro_quest/features/metro_map/logic/metro_map_controller.dart';
import 'package:metro_quest/features/metro_map/logic/metro_map_provider.dart';

class MetroMap extends ConsumerWidget {
  final List<MetroStation> stations;
  const MetroMap({super.key, required this.stations});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(metroMapControllerProvider(stations));
    final lineAsyncState = ref.watch(lineControllerProvider);
    final controller = ref.read(metroMapControllerProvider(stations).notifier);

    return asyncState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (state) => lineAsyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (lines) {
          return _buildMap(state, controller, lines, context);
        },
      ),
    );
  }

  void _displayNearStation(MetroMapController controller, BuildContext context) async {
    final stations = await controller.getStationsWithDistanceFromMe();

    if (!context.mounted) {
      return;
    }

    final selectedStationId = await showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            return ListTile(
              title: Text(station.key.name),
              subtitle: Text(station.key.lineName),
              trailing: Text('${station.value.toStringAsFixed(2)} km'),
              onTap: () {
                controller.goToStation(station.key);
                Navigator.pop(context, station.key.id);
              },
            );
          },
        );
      },
    );

    if (!context.mounted) {
      return;
    }

    if (selectedStationId != null) {
      context.go('/station/$selectedStationId');
    }
  }

  Widget _buildMap(MetroMapState state, MetroMapController controller, List<MetroLine> lines, BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _displayNearStation(controller, context),
        label: const Text('Nearest Stations'),
        icon: const Icon(Icons.directions_railway),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: state.markers,
            initialCameraPosition: CameraPosition(target: controller.initialPosition, zoom: 15),
            cameraTargetBounds: CameraTargetBounds(controller.petiteCouronneBounds),
            minMaxZoomPreference: MinMaxZoomPreference(12, 18),
            onMapCreated: controller.setMapController,
            cloudMapId: "8b18415b1444fe7478e6da95",
            mapType: MapType.terrain,
            polylines: _buildPolylines(lines),
            clusterManagers: <ClusterManager>{
              ClusterManager(
                clusterManagerId: ClusterManagerId("metro_stations"),
                onClusterTap: (cluster) {
                  // print('Cluster tapped: contains ${cluster.count} items');
                },
              ),
            },
          ),

          Text('Lines: ${lines.length}'),

          Positioned(
            top: 10,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoom_in",
                  onPressed: () async {
                    await controller.zoomIn();
                  },
                  child: Icon(Icons.zoom_in),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoom_out",
                  onPressed: () async {
                    await controller.zoomOut();
                  },
                  child: Icon(Icons.zoom_out),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "recenter",
                  onPressed: () async {
                    await controller.recenterOnUser();
                  },
                  child: Icon(Icons.my_location),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "random_station",
                  onPressed: () async {
                    await controller.goToPonderedRandomStation();
                  },
                  child: Icon(Icons.shuffle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Polyline _buildLineSegment(MetroLineSegment segment, Color color) {
    final points = segment.coordinates.map((coord) {
      return coord.toLatLng();
    }).toList();

    return Polyline(
      polylineId: PolylineId('${segment.hashCode}'),
      color: color,
      width: 4,
      points: points,
    );
  }

  List<Polyline> _buildFullLine(MetroLine line) {
    return line.lineTrace.segments.map((segment) => _buildLineSegment(segment, line.color)).toList();
  }

  Set<Polyline> _buildPolylines(List<MetroLine> lines) {
    return lines.map((line) => _buildFullLine(line)).expand((element) => element).toSet();
  }
}
