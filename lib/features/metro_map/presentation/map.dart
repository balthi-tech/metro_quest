import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:metro_quest/core/extensions/geo_point_extension.dart';
import 'package:metro_quest/core/theme/map_option.dart';
import 'package:metro_quest/domain/entities/metro_line_segment_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/features/active_navigation/logic/active_navigation_provider.dart';
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
    final activeStation = ref.watch(activeNavigationProvider);

    return asyncState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (state) => lineAsyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (lines) {
          return _buildMap(state, controller, lines, context, activeStation);
        },
      ),
    );
  }

  Widget _buildMap(
    MetroMapState state,
    MetroMapController controller,
    List<MetroLine> lines,
    BuildContext context,
    MetroStation? activeStation,
  ) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.goToPonderedRandomStation();
        },
        label: const Text('Discover'),
        icon: const Icon(Icons.directions_railway),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            markers: state.markers,
            initialCameraPosition: CameraPosition(target: controller.initialPosition, zoom: 15),
            cameraTargetBounds: CameraTargetBounds(controller.petiteCouronneBounds),
            minMaxZoomPreference: MinMaxZoomPreference(12, 18),
            onMapCreated: controller.setMapController,
            style: mapStyle,
            // mapType: MapType.normal,
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

          if (activeStation != null)
            Positioned(
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10),

                color: Theme.of(context).primaryColor.withValues(alpha: 0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.train, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'En navigation vers : ${activeStation.name}',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),

                    IconButton(
                      onPressed: () {
                        controller.cancelNavigation();
                      },
                      icon: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            top: 100,
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
