import 'package:map_launcher/map_launcher.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class MapNavigationService {
  Future<List<AvailableMap>> getAvailableMaps() async {
    final maps = await MapLauncher.installedMaps;
    return maps;
  }

  Future<void> launchDirections({
    required AvailableMap map,
    required GeoPoint geoPoint,
    required String destinationTitle,
  }) async {
    await map.showDirections(
      destination: Coords(geoPoint.latitude, geoPoint.longitude),
      destinationTitle: destinationTitle,
      directionsMode: DirectionsMode.transit,
    );
  }
}
