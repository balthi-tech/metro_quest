enum PlaceCategory {
  cafesBars,
  histoireCulture,
  activitesLoisirs,
  shoppingBoutiques,
  natureEspacesVerts,
  transports,
}

class PlaceFieldMask {
  final List<String> fields;

  const PlaceFieldMask({
    this.fields = const [
      'places.displayName',
      'places.formattedAddress',
      'places.location',
      'places.types',
    ],
  });

  String get headerValue => fields.join(',');
}

class PlaceCategoryParams {
  final List<String> includedTypes;
  final List<String> excludedTypes;
  final List<String> includedPrimaryTypes;
  final List<String> excludedPrimaryTypes;
  final String badge;

  PlaceCategoryParams({
    required this.includedTypes,
    this.excludedTypes = const [],
    this.includedPrimaryTypes = const [],
    this.excludedPrimaryTypes = const [],
    required this.badge,
  });
}

// TODO: Adjust types to better fit use cases
// actually, Places aren't persistant

Map<PlaceCategory, PlaceCategoryParams> categoryParams = {
  PlaceCategory.cafesBars: PlaceCategoryParams(
    includedTypes: [
      "restaurant",
      "cafe",
      "bakery",
      "meal_takeaway",
      "bar",
      "coffee_shop",
      "pub",
      "brunch_restaurant",
      "fast_food_restaurant",
    ],
    excludedTypes: ["night_club"],
    badge: "Gastronome du Métro",
  ),
  PlaceCategory.histoireCulture: PlaceCategoryParams(
    includedTypes: [
      "tourist_attraction",
      "museum",
      "art_gallery",
      "historical_place",
      "monument",
      "performing_arts_theater",
      "cultural_center",
      "auditorium",
      "historical_landmark",
    ],
    badge: "Historien Urbain",
  ),
  PlaceCategory.activitesLoisirs: PlaceCategoryParams(
    includedTypes: [
      "amusement_park",
      "movie_theater",
      "night_club",
      "park",
      "theater",
      "zoo",
      "aquarium",
      "casino",
      "concert_hall",
      "amusement_center",
      "event_venue",
      "roller_coaster",
      "bowling_alley",
    ],
    excludedTypes: ["school", "church"],
    badge: "Aventurier Nocturne",
  ),
  PlaceCategory.shoppingBoutiques: PlaceCategoryParams(
    includedTypes: [
      "shopping_mall",
      "clothing_store",
      "book_store",
      "department_store",
      "gift_shop",
      "market",
      "jewelry_store",
      "pet_store",
      "shoe_store",
      "liquor_store",
    ],
    excludedTypes: ["supermarket", "hardware_store"],
    badge: "Chineur Parisien",
  ),
  PlaceCategory.natureEspacesVerts: PlaceCategoryParams(
    includedTypes: [
      "park",
      "garden",
      "botanical_garden",
      "dog_park",
      "national_park",
      "state_park",
      "beach",
      "playground",
    ],
    excludedTypes: [],
    badge: "Écologiste du Béton",
  ),
  PlaceCategory.transports: PlaceCategoryParams(
    includedTypes: [
      "subway_station",
      "train_station",
      "bus_station",
      "light_rail_station",
      "ferry_terminal",
      "transit_station",
    ],
    excludedTypes: ["truck_stop"],
    badge: "Explorateur du Réseau",
  ),
};

PlaceCategoryParams getParamsForCategory(PlaceCategory category) {
  return categoryParams[category]!;
}
