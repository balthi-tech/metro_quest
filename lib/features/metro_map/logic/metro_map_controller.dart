import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metro_quest/core/extensions/geo_point_extension.dart';
import 'package:metro_quest/core/theme/metro_line_colors.dart';
import 'package:metro_quest/core/utils/distance_calculator.dart';
import 'package:metro_quest/core/utils/location_service.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/shared/providers/location_service_provider.dart';

class MetroMapState {
  final Set<String> selectedLines;
  final Set<Marker> markers;

  MetroMapState({required this.selectedLines, required this.markers});

  MetroMapState copyWith({
    Set<String>? selectedLines,
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
  late LocationService _locationService;

  MetroMapController(this.stations);

  GoogleMapController? mapController;
  final LatLngBounds petiteCouronneBounds = LatLngBounds(
    southwest: LatLng(48.7630, 2.2241),
    northeast: LatLng(48.9700, 2.5035),
  );
  final double zoom = 15.0;

  late LatLng initialPosition;

  @override
  Future<MetroMapState> build() async {
    // uncomment to use user position stream
    // final userPosition = await ref.watch(userPositionProvider.future);

    _locationService = ref.read(locationServiceProvider);

    // if (userPosition == null) {
    //   initialPosition = LatLng(48.8566, 2.3522); // Default to Paris center
    // } else {
    //   initialPosition = userPosition.toLatLng();
    // }

    try {
      initialPosition = (await _locationService.getCurrentPosition()).toLatLng();
    } catch (e) {
      initialPosition = LatLng(48.8566, 2.3522); // Default to Paris center
    }

    final allLines = MetroLineColors.lineColorMap.keys.toSet();
    return MetroMapState(
      selectedLines: allLines,
      markers: _buildMarkers(selectedLines: allLines),
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
      print('Error showing info window: $e');
    }
  }

  // Future<List<MetroStation>> sortStationByDistanceFromMe() async {
  //   // return list of stations sorted by distance from current position with the distance calculated in kilometers

  //   final currentPosition = await _locationService.getCurrentPosition();

  //   stations.sort((a, b) {
  //     final distA = DistanceCalculator.calculateDistance(currentPosition, a.geoPoint);
  //     final distB = DistanceCalculator.calculateDistance(currentPosition, b.geoPoint);

  //     return distA.compareTo(distB);
  //   });

  //   return stations;
  // }

  // return Tuple of station and distance in kilometers from current position

  Future<List<MapEntry<MetroStation, double>>> getStationsWithDistanceFromMe() async {
    final currentPosition = await _locationService.getCurrentPosition();

    final stationsWithDistance = stations.map((station) {
      final distance = DistanceCalculator.calculateDistance(currentPosition, station.geoPoint);
      return MapEntry(station, distance);
    }).toList();

    stationsWithDistance.sort((a, b) => a.value.compareTo(b.value));

    return stationsWithDistance;
  }

  void _onInfoWindowTap(MarkerId markerId) {
    // display some info or navigate to another screen

    final station = stations.firstWhereOrNull((station) => station.id == markerId.value);

    if (station == null) {
      return;
    }

    print('Info window tapped for station: ${station.name}, Line: ${station.lineName}');

    // Here you can navigate to another screen or display more information about the station
  }

  Set<Marker> _buildMarkers({required Set<String> selectedLines}) {
    return stations.where((station) => selectedLines.contains(station.lineName)).map((station) {
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
        icon: BitmapDescriptor.defaultMarkerWithHue(
          MetroLineColors.getColorHueForLine(station.lineName),
        ),
        onTap: () => _onInfoWindowTap(markerId),
      );
    }).toSet();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> onUpdateSelectedLines(Set<String> lines) async {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedLines: lines,
        markers: _buildMarkers(selectedLines: lines),
      ),
    );
  }

  Future<void> goToRandomStation() async {
    if (mapController == null) {
      return;
    }
    final available = stations.where((station) => state.value!.selectedLines.contains(station.lineName)).toList();
    if (available.isEmpty) {
      return;
    }
    final station = available[Random().nextInt(available.length)];
    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: station.geoPoint.toLatLng(), zoom: zoom)),
    );
    await mapController!.showMarkerInfoWindow(MarkerId(station.id));
  }

  // go to random station with poderation to avoid going to far stations (70% chance to go to a station within 5km, 20% chance to go to a station within 10km, 10% chance to go to a station within 20km)

  final rand = Random();

  Future<void> goToPonderedRandomStation() async {
    if (mapController == null) return;

    final stationsWithDistance = await getStationsWithDistanceFromMe();
    if (stationsWithDistance.isEmpty) return;

    final randomValue = rand.nextDouble();

    List<MapEntry<MetroStation, double>> filteredStations;

    if (randomValue < 0.7) {
      filteredStations = stationsWithDistance.where((entry) => entry.value <= 3.0).toList();
    } else if (randomValue < 0.9) {
      filteredStations = stationsWithDistance.where((entry) => entry.value > 3.0 && entry.value <= 8.0).toList();
    } else {
      filteredStations = stationsWithDistance.where((entry) => entry.value > 8.0 && entry.value <= 20.0).toList();
    }

    if (filteredStations.isEmpty) {
      filteredStations = stationsWithDistance;
    }

    final stationEntry = filteredStations[rand.nextInt(filteredStations.length)];
    final station = stationEntry.key;

    print('Going to station: ${station.name}, Distance: ${stationEntry.value.toStringAsFixed(2)} km');

    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: station.geoPoint.toLatLng(), zoom: zoom)),
    );
    await mapController!.showMarkerInfoWindow(MarkerId(station.id));
  }

  Future<void> recenterOnUser() async {
    if (mapController == null) return;
    final currentPosition = await _locationService.getCurrentPosition();
    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: currentPosition.toLatLng(), zoom: zoom)),
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
