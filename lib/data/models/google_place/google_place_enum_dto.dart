// lib/dto/google_place_enums.dart
// Enums for GooglePlace API, prefixed GooglePlace

enum GooglePlaceBusinessStatus {
  unspecified,
  operational,
  closedTemporarily,
  closedPermanently,
}

extension GooglePlaceBusinessStatusExtension on GooglePlaceBusinessStatus {
  static GooglePlaceBusinessStatus fromJson(String? value) {
    switch (value) {
      case 'OPERATIONAL':
        return GooglePlaceBusinessStatus.operational;
      case 'CLOSED_TEMPORARILY':
        return GooglePlaceBusinessStatus.closedTemporarily;
      case 'CLOSED_PERMANENTLY':
        return GooglePlaceBusinessStatus.closedPermanently;
      case 'BUSINESS_STATUS_UNSPECIFIED':
      default:
        return GooglePlaceBusinessStatus.unspecified;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlaceBusinessStatus.operational:
        return 'OPERATIONAL';
      case GooglePlaceBusinessStatus.closedTemporarily:
        return 'CLOSED_TEMPORARILY';
      case GooglePlaceBusinessStatus.closedPermanently:
        return 'CLOSED_PERMANENTLY';
      case GooglePlaceBusinessStatus.unspecified:
        return 'BUSINESS_STATUS_UNSPECIFIED';
    }
  }
}

enum GooglePlacePriceLevel {
  unspecified,
  free,
  inexpensive,
  moderate,
  expensive,
  veryExpensive,
}

extension GooglePlacePriceLevelExtension on GooglePlacePriceLevel {
  static GooglePlacePriceLevel fromJson(String? value) {
    switch (value) {
      case 'PRICE_LEVEL_FREE':
        return GooglePlacePriceLevel.free;
      case 'PRICE_LEVEL_INEXPENSIVE':
        return GooglePlacePriceLevel.inexpensive;
      case 'PRICE_LEVEL_MODERATE':
        return GooglePlacePriceLevel.moderate;
      case 'PRICE_LEVEL_EXPENSIVE':
        return GooglePlacePriceLevel.expensive;
      case 'PRICE_LEVEL_VERY_EXPENSIVE':
        return GooglePlacePriceLevel.veryExpensive;
      case 'PRICE_LEVEL_UNSPECIFIED':
      default:
        return GooglePlacePriceLevel.unspecified;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlacePriceLevel.free:
        return 'PRICE_LEVEL_FREE';
      case GooglePlacePriceLevel.inexpensive:
        return 'PRICE_LEVEL_INEXPENSIVE';
      case GooglePlacePriceLevel.moderate:
        return 'PRICE_LEVEL_MODERATE';
      case GooglePlacePriceLevel.expensive:
        return 'PRICE_LEVEL_EXPENSIVE';
      case GooglePlacePriceLevel.veryExpensive:
        return 'PRICE_LEVEL_VERY_EXPENSIVE';
      case GooglePlacePriceLevel.unspecified:
        return 'PRICE_LEVEL_UNSPECIFIED';
    }
  }
}

enum GooglePlaceFuelType {
  unspecified,
  diesel,
  dieselPlus,
  regularUnleaded,
  midgrade,
  premium,
  sp91,
  sp91E10,
  sp92,
  sp95,
  sp95E10,
  sp98,
  sp99,
  sp100,
  lpg,
  e80,
  e85,
  e100,
  methane,
  bioDiesel,
  truckDiesel,
}

extension GooglePlaceFuelTypeExtension on GooglePlaceFuelType {
  static GooglePlaceFuelType fromJson(String? value) {
    switch (value) {
      case 'DIESEL':
        return GooglePlaceFuelType.diesel;
      case 'DIESEL_PLUS':
        return GooglePlaceFuelType.dieselPlus;
      case 'REGULAR_UNLEADED':
        return GooglePlaceFuelType.regularUnleaded;
      case 'MIDGRADE':
        return GooglePlaceFuelType.midgrade;
      case 'PREMIUM':
        return GooglePlaceFuelType.premium;
      case 'SP91':
        return GooglePlaceFuelType.sp91;
      case 'SP91_E10':
        return GooglePlaceFuelType.sp91E10;
      case 'SP92':
        return GooglePlaceFuelType.sp92;
      case 'SP95':
        return GooglePlaceFuelType.sp95;
      case 'SP95_E10':
        return GooglePlaceFuelType.sp95E10;
      case 'SP98':
        return GooglePlaceFuelType.sp98;
      case 'SP99':
        return GooglePlaceFuelType.sp99;
      case 'SP100':
        return GooglePlaceFuelType.sp100;
      case 'LPG':
        return GooglePlaceFuelType.lpg;
      case 'E80':
        return GooglePlaceFuelType.e80;
      case 'E85':
        return GooglePlaceFuelType.e85;
      case 'E100':
        return GooglePlaceFuelType.e100;
      case 'METHANE':
        return GooglePlaceFuelType.methane;
      case 'BIO_DIESEL':
        return GooglePlaceFuelType.bioDiesel;
      case 'TRUCK_DIESEL':
        return GooglePlaceFuelType.truckDiesel;
      case 'FUEL_TYPE_UNSPECIFIED':
      default:
        return GooglePlaceFuelType.unspecified;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlaceFuelType.diesel:
        return 'DIESEL';
      case GooglePlaceFuelType.dieselPlus:
        return 'DIESEL_PLUS';
      case GooglePlaceFuelType.regularUnleaded:
        return 'REGULAR_UNLEADED';
      case GooglePlaceFuelType.midgrade:
        return 'MIDGRADE';
      case GooglePlaceFuelType.premium:
        return 'PREMIUM';
      case GooglePlaceFuelType.sp91:
        return 'SP91';
      case GooglePlaceFuelType.sp91E10:
        return 'SP91_E10';
      case GooglePlaceFuelType.sp92:
        return 'SP92';
      case GooglePlaceFuelType.sp95:
        return 'SP95';
      case GooglePlaceFuelType.sp95E10:
        return 'SP95_E10';
      case GooglePlaceFuelType.sp98:
        return 'SP98';
      case GooglePlaceFuelType.sp99:
        return 'SP99';
      case GooglePlaceFuelType.sp100:
        return 'SP100';
      case GooglePlaceFuelType.lpg:
        return 'LPG';
      case GooglePlaceFuelType.e80:
        return 'E80';
      case GooglePlaceFuelType.e85:
        return 'E85';
      case GooglePlaceFuelType.e100:
        return 'E100';
      case GooglePlaceFuelType.methane:
        return 'METHANE';
      case GooglePlaceFuelType.bioDiesel:
        return 'BIO_DIESEL';
      case GooglePlaceFuelType.truckDiesel:
        return 'TRUCK_DIESEL';
      case GooglePlaceFuelType.unspecified:
        return 'FUEL_TYPE_UNSPECIFIED';
    }
  }
}

enum GooglePlaceEVConnectorType {
  unspecified,
  other,
  j1772,
  type2,
  chademo,
  ccsCombo1,
  ccsCombo2,
  tesla,
  unspecifiedGbT,
  nacs,
}

extension GooglePlaceEVConnectorTypeExtension on GooglePlaceEVConnectorType {
  static GooglePlaceEVConnectorType fromJson(String? value) {
    switch (value) {
      case 'EV_CONNECTOR_TYPE_J1772':
        return GooglePlaceEVConnectorType.j1772;
      case 'EV_CONNECTOR_TYPE_TYPE_2':
        return GooglePlaceEVConnectorType.type2;
      case 'EV_CONNECTOR_TYPE_CHADEMO':
        return GooglePlaceEVConnectorType.chademo;
      case 'EV_CONNECTOR_TYPE_CCS_COMBO_1':
        return GooglePlaceEVConnectorType.ccsCombo1;
      case 'EV_CONNECTOR_TYPE_CCS_COMBO_2':
        return GooglePlaceEVConnectorType.ccsCombo2;
      case 'EV_CONNECTOR_TYPE_TESLA':
        return GooglePlaceEVConnectorType.tesla;
      case 'EV_CONNECTOR_TYPE_UNSPECIFIED_GB_T':
        return GooglePlaceEVConnectorType.unspecifiedGbT;
      case 'EV_CONNECTOR_TYPE_NACS':
        return GooglePlaceEVConnectorType.nacs;
      case 'EV_CONNECTOR_TYPE_OTHER':
        return GooglePlaceEVConnectorType.other;
      case 'EV_CONNECTOR_TYPE_UNSPECIFIED':
      default:
        return GooglePlaceEVConnectorType.unspecified;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlaceEVConnectorType.j1772:
        return 'EV_CONNECTOR_TYPE_J1772';
      case GooglePlaceEVConnectorType.type2:
        return 'EV_CONNECTOR_TYPE_TYPE_2';
      case GooglePlaceEVConnectorType.chademo:
        return 'EV_CONNECTOR_TYPE_CHADEMO';
      case GooglePlaceEVConnectorType.ccsCombo1:
        return 'EV_CONNECTOR_TYPE_CCS_COMBO_1';
      case GooglePlaceEVConnectorType.ccsCombo2:
        return 'EV_CONNECTOR_TYPE_CCS_COMBO_2';
      case GooglePlaceEVConnectorType.tesla:
        return 'EV_CONNECTOR_TYPE_TESLA';
      case GooglePlaceEVConnectorType.unspecifiedGbT:
        return 'EV_CONNECTOR_TYPE_UNSPECIFIED_GB_T';
      case GooglePlaceEVConnectorType.nacs:
        return 'EV_CONNECTOR_TYPE_NACS';
      case GooglePlaceEVConnectorType.other:
        return 'EV_CONNECTOR_TYPE_OTHER';
      case GooglePlaceEVConnectorType.unspecified:
        return 'EV_CONNECTOR_TYPE_UNSPECIFIED';
    }
  }
}

enum GooglePlaceSecondaryHoursType {
  unspecified,
  driveThrough,
  happyHour,
  delivery,
  takeout,
  kitchen,
  breakfast,
  lunch,
  dinner,
  brunch,
  pickup,
  access,
  seniorHours,
  onlineServiceHours,
}

extension GooglePlaceSecondaryHoursTypeExtension on GooglePlaceSecondaryHoursType {
  static GooglePlaceSecondaryHoursType fromJson(String? value) {
    switch (value) {
      case 'DRIVE_THROUGH':
        return GooglePlaceSecondaryHoursType.driveThrough;
      case 'HAPPY_HOUR':
        return GooglePlaceSecondaryHoursType.happyHour;
      case 'DELIVERY':
        return GooglePlaceSecondaryHoursType.delivery;
      case 'TAKEOUT':
        return GooglePlaceSecondaryHoursType.takeout;
      case 'KITCHEN':
        return GooglePlaceSecondaryHoursType.kitchen;
      case 'BREAKFAST':
        return GooglePlaceSecondaryHoursType.breakfast;
      case 'LUNCH':
        return GooglePlaceSecondaryHoursType.lunch;
      case 'DINNER':
        return GooglePlaceSecondaryHoursType.dinner;
      case 'BRUNCH':
        return GooglePlaceSecondaryHoursType.brunch;
      case 'PICKUP':
        return GooglePlaceSecondaryHoursType.pickup;
      case 'ACCESS':
        return GooglePlaceSecondaryHoursType.access;
      case 'SENIOR_HOURS':
        return GooglePlaceSecondaryHoursType.seniorHours;
      case 'ONLINE_SERVICE_HOURS':
        return GooglePlaceSecondaryHoursType.onlineServiceHours;
      case 'SECONDARY_HOURS_TYPE_UNSPECIFIED':
      default:
        return GooglePlaceSecondaryHoursType.unspecified;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlaceSecondaryHoursType.driveThrough:
        return 'DRIVE_THROUGH';
      case GooglePlaceSecondaryHoursType.happyHour:
        return 'HAPPY_HOUR';
      case GooglePlaceSecondaryHoursType.delivery:
        return 'DELIVERY';
      case GooglePlaceSecondaryHoursType.takeout:
        return 'TAKEOUT';
      case GooglePlaceSecondaryHoursType.kitchen:
        return 'KITCHEN';
      case GooglePlaceSecondaryHoursType.breakfast:
        return 'BREAKFAST';
      case GooglePlaceSecondaryHoursType.lunch:
        return 'LUNCH';
      case GooglePlaceSecondaryHoursType.dinner:
        return 'DINNER';
      case GooglePlaceSecondaryHoursType.brunch:
        return 'BRUNCH';
      case GooglePlaceSecondaryHoursType.pickup:
        return 'PICKUP';
      case GooglePlaceSecondaryHoursType.access:
        return 'ACCESS';
      case GooglePlaceSecondaryHoursType.seniorHours:
        return 'SENIOR_HOURS';
      case GooglePlaceSecondaryHoursType.onlineServiceHours:
        return 'ONLINE_SERVICE_HOURS';
      case GooglePlaceSecondaryHoursType.unspecified:
        return 'SECONDARY_HOURS_TYPE_UNSPECIFIED';
    }
  }
}

enum GooglePlaceSpatialRelationship {
  near,
  within,
  beside,
  acrossTheRoad,
  downTheRoad,
  aroundTheCorner,
  behind,
}

extension GooglePlaceSpatialRelationshipExtension on GooglePlaceSpatialRelationship {
  static GooglePlaceSpatialRelationship fromJson(String? value) {
    switch (value) {
      case 'WITHIN':
        return GooglePlaceSpatialRelationship.within;
      case 'BESIDE':
        return GooglePlaceSpatialRelationship.beside;
      case 'ACROSS_THE_ROAD':
        return GooglePlaceSpatialRelationship.acrossTheRoad;
      case 'DOWN_THE_ROAD':
        return GooglePlaceSpatialRelationship.downTheRoad;
      case 'AROUND_THE_CORNER':
        return GooglePlaceSpatialRelationship.aroundTheCorner;
      case 'BEHIND':
        return GooglePlaceSpatialRelationship.behind;
      case 'NEAR':
      default:
        return GooglePlaceSpatialRelationship.near;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlaceSpatialRelationship.within:
        return 'WITHIN';
      case GooglePlaceSpatialRelationship.beside:
        return 'BESIDE';
      case GooglePlaceSpatialRelationship.acrossTheRoad:
        return 'ACROSS_THE_ROAD';
      case GooglePlaceSpatialRelationship.downTheRoad:
        return 'DOWN_THE_ROAD';
      case GooglePlaceSpatialRelationship.aroundTheCorner:
        return 'AROUND_THE_CORNER';
      case GooglePlaceSpatialRelationship.behind:
        return 'BEHIND';
      case GooglePlaceSpatialRelationship.near:
        return 'NEAR';
    }
  }
}

enum GooglePlaceContainment {
  unspecified,
  within,
  outskirts,
  near,
}

extension GooglePlaceContainmentExtension on GooglePlaceContainment {
  static GooglePlaceContainment fromJson(String? value) {
    switch (value) {
      case 'WITHIN':
        return GooglePlaceContainment.within;
      case 'OUTSKIRTS':
        return GooglePlaceContainment.outskirts;
      case 'NEAR':
        return GooglePlaceContainment.near;
      case 'CONTAINMENT_UNSPECIFIED':
      default:
        return GooglePlaceContainment.unspecified;
    }
  }

  String toJson() {
    switch (this) {
      case GooglePlaceContainment.within:
        return 'WITHIN';
      case GooglePlaceContainment.outskirts:
        return 'OUTSKIRTS';
      case GooglePlaceContainment.near:
        return 'NEAR';
      case GooglePlaceContainment.unspecified:
        return 'CONTAINMENT_UNSPECIFIED';
    }
  }
}
