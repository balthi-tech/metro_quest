class Station {
  final String routeId;
  final String routeLongName;
  final String stopId;
  final String stopName;
  final String stopLon;
  final String stopLat;
  final String operatorName;
  final String shortName;
  final String mode;
  final List<double>? pointgeo;
  final String nomCommune;
  final String codeInsee;
  final String? funfact;
  final String? histoire;
  final bool visited;

  Station({
    required this.routeId,
    required this.routeLongName,
    required this.stopId,
    required this.stopName,
    required this.stopLon,
    required this.stopLat,
    required this.operatorName,
    required this.shortName,
    required this.mode,
    this.pointgeo,
    required this.nomCommune,
    required this.codeInsee,
    this.funfact,
    this.histoire,
    this.visited = false,
  });
}
