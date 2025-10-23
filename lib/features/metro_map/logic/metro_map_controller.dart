import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metro_quest/core/extensions/geo_point_extension.dart';
import 'package:metro_quest/core/router/app_router.dart';
import 'package:metro_quest/core/theme/metro_line_colors.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/features/active_navigation/logic/active_navigation_provider.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/providers/local_notification_service_provider.dart';
import 'package:metro_quest/shared/providers/location_service_provider.dart';

class MetroMapState {
  final Set<MetroLine> selectedLines;
  final Set<Marker> markers;

  MetroMapState({required this.selectedLines, required this.markers});

  MetroMapState copyWith({
    Set<MetroLine>? selectedLines,
    Set<Marker>? markers,
  }) {
    return MetroMapState(
      selectedLines: selectedLines ?? this.selectedLines,
      markers: markers ?? this.markers,
    );
  }
}

class MetroMapController extends AsyncNotifier<MetroMapState> {
  final List<MetroStation> stations;

  MetroMapController({required this.stations});

  GoogleMapController? mapController;
  final LatLngBounds petiteCouronneBounds = LatLngBounds(
    southwest: LatLng(48.7630, 2.2241),
    northeast: LatLng(48.9700, 2.5035),
  );
  final double zoom = 15.0;

  late LatLng initialPosition;
  late LatLng currentPosition;

  @override
  Future<MetroMapState> build() async {
    final asyncPosition = ref.watch(userPositionProvider);

    final LatLng positionLatLng = asyncPosition.maybeWhen(
      data: (geoPoint) => geoPoint?.toLatLng() ?? const LatLng(48.8566, 2.3522),
      orElse: () => const LatLng(48.8566, 2.3522),
    );

    initialPosition = positionLatLng;
    currentPosition = positionLatLng;

    final lines = await ref.watch(lineControllerProvider.future);

    // generate an icon for each line, and save it in a map on line id

    final Map<String, BitmapDescriptor> lineIcons = await Future.wait(
      lines.map((line) async {
        final icon = await MetroLineColors.createStyledMarker(
          line.color,
          size: 40,
        );
        return MapEntry(line.id, icon);
      }),
    ).then((entries) => Map.fromEntries(entries));

    final defaultIcon = await MetroLineColors.createStyledMarker(
      Colors.grey,
      size: 40,
    );

    return MetroMapState(
      selectedLines: lines.toSet(),
      markers: _buildMarkers(selectedLines: lines.toSet(), lineIcons: lineIcons, defaultIcon: defaultIcon),
    );
  }

  void goToStation(MetroStation station) async {
    if (mapController == null) {
      return;
    }

    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: station.geoPoint.toLatLng(), zoom: zoom)),
    );

    try {
      await mapController!.showMarkerInfoWindow(MarkerId(station.id));
    } catch (e) {
      if (kDebugMode) {
        print('Error showing info window: $e');
      }
    }
  }

  void cancelNavigation() {
    ref.read(activeNavigationProvider.notifier).stopNavigation();
  }

  void _onInfoWindowTap(MarkerId markerId) {
    Log.d('Info window tapped for markerId: ${markerId.value}');
    // display some info or navigate to another screen

    final station = stations.firstWhereOrNull((station) => station.id == markerId.value);

    if (station == null) {
      return;
    }

    // TODO : check if it's okay
    navigatorKey.currentContext?.push('/station/${station.id}');

    // Here you can navigate to another screen or display more information about the station
  }

  Set<Marker> _buildMarkers({
    required Set<MetroLine> selectedLines,
    required Map<String, BitmapDescriptor> lineIcons,
    required BitmapDescriptor defaultIcon,
  }) {
    final filteredStations = stations.where((station) => selectedLines.any((line) => line.id == station.lineId));

    return filteredStations.map((station) {
      bool isVisitedStation = station.visited;

      final markerId = MarkerId(station.id);

      return Marker(
        markerId: markerId,
        position: station.geoPoint.toLatLng(),
        infoWindow: InfoWindow(
          title: station.name,
          snippet: station.lineName,
          onTap: () => _onInfoWindowTap(markerId),
        ),
        clusterManagerId: ClusterManagerId("metro_stations"),
        icon: isVisitedStation ? (lineIcons[station.lineId] ?? defaultIcon) : defaultIcon,

        onDrag: (value) {
          Log.d('Marker dragged to $value');
        },
        onDragStart: (value) => Log.d('Marker drag started at $value'),
        onDragEnd: (value) => Log.d('Marker drag ended at $value'),

        onTap: () {
          // You can handle marker tap if needed
          if (Platform.isAndroid) {
            // On Android, info window does not open automatically on marker tap
            _onInfoWindowTap(markerId);
          }
        },
      );
    }).toSet();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  // Future<void> onUpdateSelectedLines(Set<MetroLine> lines) async {
  //   state = AsyncValue.data(
  //     state.value!.copyWith(
  //       selectedLines: lines,
  //       markers: _buildMarkers(selectedLines: lines),
  //     ),
  //   );
  // }

  Future<void> goToPonderedRandomStation() async {
    if (mapController == null) {
      return;
    }

    // filter stations to only choose in not visited ones

    final notVisitedStations = ref
        .read(filterStationsUseCaseProvider)
        .execute(
          metroStations: stations,
          criteria: MetroStationFilterCriterias(visited: false),
        );

    final randomStation = ref.read(selectRandomStationUseCaseProvider).execute(notVisitedStations);

    if (randomStation == null) {
      return;
    }

    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: randomStation.geoPoint.toLatLng(), zoom: zoom)),
    );

    // await 500 milliseconds to ensure the camera has moved
    await Future.delayed(const Duration(milliseconds: 500));
    await mapController!.showMarkerInfoWindow(MarkerId(randomStation.id));

    // // send local notification about the selected station
    await ref
        .read(notificationServiceProvider)
        .showNotification(
          title: 'Station Suggestion',
          body: 'How about visiting ${randomStation.name} on line ${randomStation.lineName}?',
        );
  }

  Future<void> recenterOnUser() async {
    if (mapController == null) {
      return;
    }

    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: currentPosition, zoom: zoom)),
    );
  }

  // Future<GeoPoint> _getCurrentPosition() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) throw Exception('Location services are disabled.');
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw Exception('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception('Location permissions are permanently denied');
  //   }
  //   final position = await Geolocator.getCurrentPosition();
  //   return GeoPoint(latitude: position.latitude, longitude: position.longitude);
  // }

  Future<void> zoomIn() async {
    if (mapController == null) {
      return;
    }

    await mapController!.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> zoomOut() async {
    if (mapController == null) {
      return;
    }

    await mapController!.animateCamera(CameraUpdate.zoomOut());
  }
}
