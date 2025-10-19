class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'GeoPoint(latitude: $latitude, longitude: $longitude)';
  }
}
