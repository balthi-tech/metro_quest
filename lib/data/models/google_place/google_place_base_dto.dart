// lib/dto/google_place_base.dart

class GooglePlaceLocalizedText {
  final String text;
  final String languageCode;

  GooglePlaceLocalizedText({required this.text, required this.languageCode});

  factory GooglePlaceLocalizedText.fromJson(Map<String, dynamic> json) => GooglePlaceLocalizedText(
    text: json['text'] as String? ?? '',
    languageCode: json['languageCode'] as String? ?? '',
  );
}

class GooglePlacePostalAddress {
  final int? revision;
  final String? regionCode;
  final String? languageCode;
  final String? postalCode;
  final String? sortingCode;
  final String? administrativeArea;
  final String? locality;
  final String? sublocality;
  final List<String>? addressLines;
  final List<String>? recipients;
  final String? organization;

  GooglePlacePostalAddress({
    this.revision,
    this.regionCode,
    this.languageCode,
    this.postalCode,
    this.sortingCode,
    this.administrativeArea,
    this.locality,
    this.sublocality,
    this.addressLines,
    this.recipients,
    this.organization,
  });

  factory GooglePlacePostalAddress.fromJson(Map<String, dynamic> json) => GooglePlacePostalAddress(
    revision: json['revision'],
    regionCode: json['regionCode'],
    languageCode: json['languageCode'],
    postalCode: json['postalCode'],
    sortingCode: json['sortingCode'],
    administrativeArea: json['administrativeArea'],
    locality: json['locality'],
    sublocality: json['sublocality'],
    addressLines: (json['addressLines'] as List?)?.cast<String>(),
    recipients: (json['recipients'] as List?)?.cast<String>(),
    organization: json['organization'],
  );
}

class GooglePlaceAddressComponent {
  final String longText;
  final String shortText;
  final List<String> types;
  final String languageCode;

  GooglePlaceAddressComponent({
    required this.longText,
    required this.shortText,
    required this.types,
    required this.languageCode,
  });

  factory GooglePlaceAddressComponent.fromJson(Map<String, dynamic> json) => GooglePlaceAddressComponent(
    longText: json['longText'] as String? ?? '',
    shortText: json['shortText'] as String? ?? '',
    types: (json['types'] as List<dynamic>?)?.cast<String>() ?? [],
    languageCode: json['languageCode'] as String? ?? '',
  );
}

class GooglePlacePlusCode {
  final String globalCode;
  final String? compoundCode;

  GooglePlacePlusCode({required this.globalCode, this.compoundCode});

  factory GooglePlacePlusCode.fromJson(Map<String, dynamic> json) => GooglePlacePlusCode(
    globalCode: json['globalCode'] as String,
    compoundCode: json['compoundCode'] as String?,
  );
}

class GooglePlaceLatLng {
  final double latitude;
  final double longitude;

  GooglePlaceLatLng({required this.latitude, required this.longitude});

  factory GooglePlaceLatLng.fromJson(Map<String, dynamic> json) => GooglePlaceLatLng(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

class GooglePlaceViewport {
  final GooglePlaceLatLng? low;
  final GooglePlaceLatLng? high;

  GooglePlaceViewport({this.low, this.high});

  factory GooglePlaceViewport.fromJson(Map<String, dynamic> json) => GooglePlaceViewport(
    low: json['low'] != null ? GooglePlaceLatLng.fromJson(json['low']) : null,
    high: json['high'] != null ? GooglePlaceLatLng.fromJson(json['high']) : null,
  );
}

// Review
class GooglePlaceReview {
  final String? authorName;
  final String? relativePublishTimeDescription;
  final GooglePlaceLocalizedText? text;
  final GooglePlaceLocalizedText? originalText;
  final double? rating;
  final GooglePlaceAuthorAttribution? authorAttribution;
  final String? publishTime;

  GooglePlaceReview({
    this.authorName,
    this.relativePublishTimeDescription,
    this.text,
    this.originalText,
    this.rating,
    this.authorAttribution,
    this.publishTime,
  });

  factory GooglePlaceReview.fromJson(Map<String, dynamic> json) => GooglePlaceReview(
    authorName: json['name'] as String?,
    relativePublishTimeDescription: json['relativePublishTimeDescription'] as String?,
    text: json['text'] != null ? GooglePlaceLocalizedText.fromJson(json['text']) : null,
    originalText: json['originalText'] != null ? GooglePlaceLocalizedText.fromJson(json['originalText']) : null,
    rating: (json['rating'] as num?)?.toDouble(),
    authorAttribution: json['authorAttribution'] != null
        ? GooglePlaceAuthorAttribution.fromJson(json['authorAttribution'])
        : null,
    publishTime: json['publishTime'] as String?,
  );
}

// AuthorAttribution
class GooglePlaceAuthorAttribution {
  final String? displayName;
  final String? uri;
  final String? photoUri;

  GooglePlaceAuthorAttribution({this.displayName, this.uri, this.photoUri});

  factory GooglePlaceAuthorAttribution.fromJson(Map<String, dynamic> json) => GooglePlaceAuthorAttribution(
    displayName: json['displayName'] as String?,
    uri: json['uri'] as String?,
    photoUri: json['photoUri'] as String?,
  );
}

// Photo
class GooglePlacePhoto {
  final String name;
  final int? widthPx;
  final int? heightPx;
  final List<GooglePlaceAuthorAttribution>? authorAttributions;
  final String? googleMapsUri;

  GooglePlacePhoto({required this.name, this.widthPx, this.heightPx, this.authorAttributions, this.googleMapsUri});

  factory GooglePlacePhoto.fromJson(Map<String, dynamic> json) => GooglePlacePhoto(
    name: json['name'] as String,
    widthPx: json['widthPx'] as int?,
    heightPx: json['heightPx'] as int?,
    authorAttributions: json['authorAttributions'] != null
        ? (json['authorAttributions'] as List).map((e) => GooglePlaceAuthorAttribution.fromJson(e)).toList()
        : null,
    googleMapsUri: json['googleMapsUri'] as String?,
  );
}

// OpeningHours
class GooglePlaceOpeningHours {
  final List<GooglePlacePeriod>? periods;
  final List<String>? weekdayDescriptions;
  final String? secondaryHoursType;
  final List<GooglePlaceSpecialDay>? specialDays;
  final String? nextOpenTime;
  final String? nextCloseTime;
  final bool? openNow;

  GooglePlaceOpeningHours({
    this.periods,
    this.weekdayDescriptions,
    this.secondaryHoursType,
    this.specialDays,
    this.nextOpenTime,
    this.nextCloseTime,
    this.openNow,
  });

  factory GooglePlaceOpeningHours.fromJson(Map<String, dynamic> json) => GooglePlaceOpeningHours(
    periods: json['periods'] != null
        ? (json['periods'] as List).map((e) => GooglePlacePeriod.fromJson(e)).toList()
        : null,
    weekdayDescriptions: (json['weekdayDescriptions'] as List<dynamic>?)?.cast<String>(),
    secondaryHoursType: json['secondaryHoursType'] as String?,
    specialDays: json['specialDays'] != null
        ? (json['specialDays'] as List).map((e) => GooglePlaceSpecialDay.fromJson(e)).toList()
        : null,
    nextOpenTime: json['nextOpenTime'] as String?,
    nextCloseTime: json['nextCloseTime'] as String?,
    openNow: json['openNow'] as bool?,
  );
}

// Period
class GooglePlacePeriod {
  final GooglePlacePoint? open;
  final GooglePlacePoint? close;

  GooglePlacePeriod({this.open, this.close});

  factory GooglePlacePeriod.fromJson(Map<String, dynamic> json) => GooglePlacePeriod(
    open: json['open'] != null ? GooglePlacePoint.fromJson(json['open']) : null,
    close: json['close'] != null ? GooglePlacePoint.fromJson(json['close']) : null,
  );
}

// Point
class GooglePlacePoint {
  final GooglePlaceDate? date;
  final bool? truncated;
  final int? day;
  final int? hour;
  final int? minute;

  GooglePlacePoint({this.date, this.truncated, this.day, this.hour, this.minute});

  factory GooglePlacePoint.fromJson(Map<String, dynamic> json) => GooglePlacePoint(
    date: json['date'] != null ? GooglePlaceDate.fromJson(json['date']) : null,
    truncated: json['truncated'],
    day: json['day'],
    hour: json['hour'],
    minute: json['minute'],
  );
}

// Date
class GooglePlaceDate {
  final int year;
  final int month;
  final int day;

  GooglePlaceDate({required this.year, required this.month, required this.day});

  factory GooglePlaceDate.fromJson(Map<String, dynamic> json) =>
      GooglePlaceDate(year: json['year'], month: json['month'], day: json['day']);
}

// SpecialDay
class GooglePlaceSpecialDay {
  final GooglePlaceDate? date;

  GooglePlaceSpecialDay({this.date});

  factory GooglePlaceSpecialDay.fromJson(Map<String, dynamic> json) =>
      GooglePlaceSpecialDay(date: json['date'] != null ? GooglePlaceDate.fromJson(json['date']) : null);
}

// TimeZone
class GooglePlaceTimeZone {
  final String? id;
  final String? version;

  GooglePlaceTimeZone({this.id, this.version});

  factory GooglePlaceTimeZone.fromJson(Map<String, dynamic> json) =>
      GooglePlaceTimeZone(id: json['id'], version: json['version']);
}

// Money
class GooglePlaceMoney {
  final String currencyCode;
  final String units;
  final int nanos;

  GooglePlaceMoney({required this.currencyCode, required this.units, required this.nanos});

  factory GooglePlaceMoney.fromJson(Map<String, dynamic> json) => GooglePlaceMoney(
    currencyCode: json['currencyCode'],
    units: json['units'],
    nanos: json['nanos'],
  );
}

// PaymentOptions
class GooglePlacePaymentOptions {
  final bool? acceptsCreditCards;
  final bool? acceptsDebitCards;
  final bool? acceptsCashOnly;
  final bool? acceptsNfc;

  GooglePlacePaymentOptions({this.acceptsCreditCards, this.acceptsDebitCards, this.acceptsCashOnly, this.acceptsNfc});

  factory GooglePlacePaymentOptions.fromJson(Map<String, dynamic> json) => GooglePlacePaymentOptions(
    acceptsCreditCards: json['acceptsCreditCards'],
    acceptsDebitCards: json['acceptsDebitCards'],
    acceptsCashOnly: json['acceptsCashOnly'],
    acceptsNfc: json['acceptsNfc'],
  );
}

// SubDestination
class GooglePlaceSubDestination {
  final String name;
  final String id;

  GooglePlaceSubDestination({required this.name, required this.id});

  factory GooglePlaceSubDestination.fromJson(Map<String, dynamic> json) =>
      GooglePlaceSubDestination(name: json['name'], id: json['id']);
}

// FuelOptions
class GooglePlaceFuelOptions {
  final List<GooglePlaceFuelPrice>? fuelPrices;

  GooglePlaceFuelOptions({this.fuelPrices});

  factory GooglePlaceFuelOptions.fromJson(Map<String, dynamic> json) => GooglePlaceFuelOptions(
    fuelPrices: (json['fuelPrices'] as List<dynamic>?)?.map((e) => GooglePlaceFuelPrice.fromJson(e)).toList(),
  );
}

class GooglePlaceFuelPrice {
  final String? type;
  final GooglePlaceMoney? price;
  final String? updateTime;

  GooglePlaceFuelPrice({this.type, this.price, this.updateTime});

  factory GooglePlaceFuelPrice.fromJson(Map<String, dynamic> json) => GooglePlaceFuelPrice(
    type: json['type'] as String?,
    price: json['price'] != null ? GooglePlaceMoney.fromJson(json['price']) : null,
    updateTime: json['updateTime'] as String?,
  );
}

// EvChargeOptions
class GooglePlaceEvChargeOptions {
  final List<GooglePlaceConnectorAggregation>? connectorAggregation;

  GooglePlaceEvChargeOptions({this.connectorAggregation});

  factory GooglePlaceEvChargeOptions.fromJson(Map<String, dynamic> json) => GooglePlaceEvChargeOptions(
    connectorAggregation: (json['connectorAggregation'] as List<dynamic>?)
        ?.map((e) => GooglePlaceConnectorAggregation.fromJson(e))
        .toList(),
  );
}

class GooglePlaceConnectorAggregation {
  final String? type;
  final double? maxChargeRateKw;
  final int? count;
  final String? availabilityLastUpdateTime;
  final int? availableCount;
  final int? outOfServiceCount;

  GooglePlaceConnectorAggregation({
    this.type,
    this.maxChargeRateKw,
    this.count,
    this.availabilityLastUpdateTime,
    this.availableCount,
    this.outOfServiceCount,
  });

  factory GooglePlaceConnectorAggregation.fromJson(Map<String, dynamic> json) => GooglePlaceConnectorAggregation(
    type: json['type'] as String?,
    maxChargeRateKw: (json['maxChargeRateKw'] as num?)?.toDouble(),
    count: json['count'] as int?,
    availabilityLastUpdateTime: json['availabilityLastUpdateTime'] as String?,
    availableCount: json['availableCount'] as int?,
    outOfServiceCount: json['outOfServiceCount'] as int?,
  );
}

// GenerativeSummary
class GooglePlaceGenerativeSummary {
  final GooglePlaceLocalizedText? overview;
  final String? overviewFlagContentUri;
  final GooglePlaceLocalizedText? disclosureText;

  GooglePlaceGenerativeSummary({this.overview, this.overviewFlagContentUri, this.disclosureText});

  factory GooglePlaceGenerativeSummary.fromJson(Map<String, dynamic> json) => GooglePlaceGenerativeSummary(
    overview: json['overview'] != null ? GooglePlaceLocalizedText.fromJson(json['overview']) : null,
    overviewFlagContentUri: json['overviewFlagContentUri'] as String?,
    disclosureText: json['disclosureText'] != null ? GooglePlaceLocalizedText.fromJson(json['disclosureText']) : null,
  );
}

// ContainingPlace
class GooglePlaceContainingPlace {
  final String name;
  final String id;

  GooglePlaceContainingPlace({required this.name, required this.id});

  factory GooglePlaceContainingPlace.fromJson(Map<String, dynamic> json) =>
      GooglePlaceContainingPlace(name: json['name'], id: json['id']);
}

// AddressDescriptor
class GooglePlaceAddressDescriptor {
  final List<GooglePlaceContainingPlace>? landmarks;
  final List<GooglePlaceContainingPlace>? areas;

  GooglePlaceAddressDescriptor({this.landmarks, this.areas});

  factory GooglePlaceAddressDescriptor.fromJson(Map<String, dynamic> json) => GooglePlaceAddressDescriptor(
    landmarks: (json['landmarks'] as List<dynamic>?)?.map((e) => GooglePlaceContainingPlace.fromJson(e)).toList(),
    areas: (json['areas'] as List<dynamic>?)?.map((e) => GooglePlaceContainingPlace.fromJson(e)).toList(),
  );
}

// GoogleMapsLinks
class GooglePlaceMapsLinks {
  final String? directionsUri;
  final String? placeUri;
  final String? writeAReviewUri;
  final String? reviewsUri;
  final String? photosUri;

  GooglePlaceMapsLinks({
    this.directionsUri,
    this.placeUri,
    this.writeAReviewUri,
    this.reviewsUri,
    this.photosUri,
  });

  factory GooglePlaceMapsLinks.fromJson(Map<String, dynamic> json) => GooglePlaceMapsLinks(
    directionsUri: json['directionsUri'] as String?,
    placeUri: json['placeUri'] as String?,
    writeAReviewUri: json['writeAReviewUri'] as String?,
    reviewsUri: json['reviewsUri'] as String?,
    photosUri: json['photosUri'] as String?,
  );
}

// PriceRange
class GooglePlaceMoneyRange {
  final GooglePlaceMoney? startPrice;
  final GooglePlaceMoney? endPrice;

  GooglePlaceMoneyRange({this.startPrice, this.endPrice});

  factory GooglePlaceMoneyRange.fromJson(Map<String, dynamic> json) => GooglePlaceMoneyRange(
    startPrice: json['startPrice'] != null ? GooglePlaceMoney.fromJson(json['startPrice']) : null,
    endPrice: json['endPrice'] != null ? GooglePlaceMoney.fromJson(json['endPrice']) : null,
  );
}

class GooglePlacePriceRange {
  final GooglePlaceMoney? startPrice;
  final GooglePlaceMoney? endPrice;

  GooglePlacePriceRange({this.startPrice, this.endPrice});

  factory GooglePlacePriceRange.fromJson(Map<String, dynamic> json) => GooglePlacePriceRange(
    startPrice: json['startPrice'] != null ? GooglePlaceMoney.fromJson(json['startPrice']) : null,
    endPrice: json['endPrice'] != null ? GooglePlaceMoney.fromJson(json['endPrice']) : null,
  );
}

// ReviewSummary
class GooglePlaceReviewSummary {
  final GooglePlaceLocalizedText? text;
  final String? flagContentUri;
  final GooglePlaceLocalizedText? disclosureText;
  final String? reviewsUri;

  GooglePlaceReviewSummary({this.text, this.flagContentUri, this.disclosureText, this.reviewsUri});

  factory GooglePlaceReviewSummary.fromJson(Map<String, dynamic> json) => GooglePlaceReviewSummary(
    text: json['text'] != null ? GooglePlaceLocalizedText.fromJson(json['text']) : null,
    flagContentUri: json['flagContentUri'] as String?,
    disclosureText: json['disclosureText'] != null ? GooglePlaceLocalizedText.fromJson(json['disclosureText']) : null,
    reviewsUri: json['reviewsUri'] as String?,
  );
}

// EvChargeAmenitySummary
class GooglePlaceEvChargeAmenitySummary {
  final GooglePlaceLocalizedText? overview;
  final GooglePlaceLocalizedText? coffee;
  final GooglePlaceLocalizedText? restaurant;
  final GooglePlaceLocalizedText? store;
  final String? flagContentUri;
  final GooglePlaceLocalizedText? disclosureText;

  GooglePlaceEvChargeAmenitySummary({
    this.overview,
    this.coffee,
    this.restaurant,
    this.store,
    this.flagContentUri,
    this.disclosureText,
  });

  factory GooglePlaceEvChargeAmenitySummary.fromJson(Map<String, dynamic> json) => GooglePlaceEvChargeAmenitySummary(
    overview: json['overview'] != null ? GooglePlaceLocalizedText.fromJson(json['overview']) : null,
    coffee: json['coffee'] != null ? GooglePlaceLocalizedText.fromJson(json['coffee']) : null,
    restaurant: json['restaurant'] != null ? GooglePlaceLocalizedText.fromJson(json['restaurant']) : null,
    store: json['store'] != null ? GooglePlaceLocalizedText.fromJson(json['store']) : null,
    flagContentUri: json['flagContentUri'] as String?,
    disclosureText: json['disclosureText'] != null ? GooglePlaceLocalizedText.fromJson(json['disclosureText']) : null,
  );
}

// NeighborhoodSummary
class GooglePlaceNeighborhoodSummary {
  final GooglePlaceLocalizedText? overview;
  final GooglePlaceLocalizedText? description;
  final String? flagContentUri;
  final GooglePlaceLocalizedText? disclosureText;

  GooglePlaceNeighborhoodSummary({this.overview, this.description, this.flagContentUri, this.disclosureText});

  factory GooglePlaceNeighborhoodSummary.fromJson(Map<String, dynamic> json) => GooglePlaceNeighborhoodSummary(
    overview: json['overview'] != null ? GooglePlaceLocalizedText.fromJson(json['overview']) : null,
    description: json['description'] != null ? GooglePlaceLocalizedText.fromJson(json['description']) : null,
    flagContentUri: json['flagContentUri'] as String?,
    disclosureText: json['disclosureText'] != null ? GooglePlaceLocalizedText.fromJson(json['disclosureText']) : null,
  );
}

// ConsumerAlert
class GooglePlaceConsumerAlert {
  final String? overview;
  final GooglePlaceDetails? details;
  final String? languageCode;

  GooglePlaceConsumerAlert({this.overview, this.details, this.languageCode});

  factory GooglePlaceConsumerAlert.fromJson(Map<String, dynamic> json) => GooglePlaceConsumerAlert(
    overview: json['overview'] as String?,
    details: json['details'] != null ? GooglePlaceDetails.fromJson(json['details']) : null,
    languageCode: json['languageCode'] as String?,
  );
}

class GooglePlaceDetails {
  final String? title;
  final String? description;
  final GooglePlaceLink? aboutLink;

  GooglePlaceDetails({this.title, this.description, this.aboutLink});

  factory GooglePlaceDetails.fromJson(Map<String, dynamic> json) => GooglePlaceDetails(
    title: json['title'] as String?,
    description: json['description'] as String?,
    aboutLink: json['aboutLink'] != null ? GooglePlaceLink.fromJson(json['aboutLink']) : null,
  );
}

class GooglePlaceLink {
  final String? title;
  final String? uri;

  GooglePlaceLink({this.title, this.uri});

  factory GooglePlaceLink.fromJson(Map<String, dynamic> json) => GooglePlaceLink(
    title: json['title'] as String?,
    uri: json['uri'] as String?,
  );
}

// AccessibilityOptions
class GooglePlaceAccessibilityOptions {
  final bool? wheelchairAccessibleParking;
  final bool? wheelchairAccessibleEntrance;
  final bool? wheelchairAccessibleRestroom;
  final bool? wheelchairAccessibleSeating;

  GooglePlaceAccessibilityOptions({
    this.wheelchairAccessibleParking,
    this.wheelchairAccessibleEntrance,
    this.wheelchairAccessibleRestroom,
    this.wheelchairAccessibleSeating,
  });

  factory GooglePlaceAccessibilityOptions.fromJson(Map<String, dynamic> json) => GooglePlaceAccessibilityOptions(
    wheelchairAccessibleParking: json['wheelchairAccessibleParking'] as bool?,
    wheelchairAccessibleEntrance: json['wheelchairAccessibleEntrance'] as bool?,
    wheelchairAccessibleRestroom: json['wheelchairAccessibleRestroom'] as bool?,
    wheelchairAccessibleSeating: json['wheelchairAccessibleSeating'] as bool?,
  );
}

// Attribution

class GooglePlaceAttribution {
  final String provider;
  final String providerUri;

  GooglePlaceAttribution({required this.provider, required this.providerUri});

  factory GooglePlaceAttribution.fromJson(Map<String, dynamic> json) => GooglePlaceAttribution(
    provider: json['provider'] as String,
    providerUri: json['providerUri'] as String,
  );
}

// ParkingOptions
class GooglePlaceParkingOptions {
  final bool? freeParkingLot;
  final bool? paidParkingLot;
  final bool? freeStreetParking;
  final bool? paidStreetParking;
  final bool? valetParking;
  final bool? freeGarageParking;
  final bool? paidGarageParking;

  GooglePlaceParkingOptions({
    this.freeParkingLot,
    this.paidParkingLot,
    this.freeStreetParking,
    this.paidStreetParking,
    this.valetParking,
    this.freeGarageParking,
    this.paidGarageParking,
  });

  factory GooglePlaceParkingOptions.fromJson(Map<String, dynamic> json) => GooglePlaceParkingOptions(
    freeParkingLot: json['freeParkingLot'] as bool?,
    paidParkingLot: json['paidParkingLot'] as bool?,
    freeStreetParking: json['freeStreetParking'] as bool?,
    paidStreetParking: json['paidStreetParking'] as bool?,
    valetParking: json['valetParking'] as bool?,
    freeGarageParking: json['freeGarageParking'] as bool?,
    paidGarageParking: json['paidGarageParking'] as bool?,
  );
}
