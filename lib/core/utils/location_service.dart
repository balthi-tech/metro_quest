import 'package:geolocator/geolocator.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class LocationService {
  Future<GeoPoint> getCurrentPosition() async {
    print('Requesting current position...');
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permission de localisation refusée.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permission de localisation refusée de façon permanente.');
    }

    final position = await Geolocator.getCurrentPosition();

    return GeoPoint(latitude: position.latitude, longitude: position.longitude);
  }
}

class LocationStreamService {
  Stream<GeoPoint> getPositionStream({
    LocationSettings? locationSettings,
  }) {
    // Paramètres par défaut : équilibrés entre précision et consommation
    final settings =
        locationSettings ??
        const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 20, // émet une mise à jour tous les ~20m de déplacement
        );

    return Geolocator.getPositionStream(
      locationSettings: settings,
    ).map((position) => GeoPoint(latitude: position.latitude, longitude: position.longitude));
  }
}

// TODO: Implementer le stream de position au lieu de le faire dans le controller de la map

// class LocationServiceNew {
//   Stream<GeoPoint> getPositionStream({
//     LocationSettings? locationSettings,
//   }) {

//     bool serviceAndPermissionOk = await checkServiceAndPermission();

//     final settings =
//         locationSettings ??
//         const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//           distanceFilter: 20, // notifications tous les 20m de déplacement
//         );

//     return Geolocator.getPositionStream(
//       locationSettings: settings,
//     ).map((position) => GeoPoint(latitude: position.latitude, longitude: position.longitude));
//   }

//   Future<bool> checkServiceAndPermission() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print('Location services are disabled.');
//       return false;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print('Location permission denied.');
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       print('Location permission denied forever.');
//       return false;
//     }

//     return true;
//   }
// }
