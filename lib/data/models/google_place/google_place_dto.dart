import 'package:metro_quest/data/models/google_place/google_place_base_dto.dart';
import 'package:metro_quest/data/models/google_place/google_place_enum_dto.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/domain/entities/place_entity.dart';

class GooglePlaceDto {
  final String name;
  final String id;
  final GooglePlaceLocalizedText? displayName;
  final List<String> types;
  final String? primaryType;
  final GooglePlaceLocalizedText? primaryTypeDisplayName;
  final String? nationalPhoneNumber;
  final String? internationalPhoneNumber;
  final String? formattedAddress;
  final String? shortFormattedAddress;
  final GooglePlacePostalAddress? postalAddress;
  final List<GooglePlaceAddressComponent>? addressComponents;
  final GooglePlacePlusCode? plusCode;
  final GooglePlaceLatLng? location;
  final GooglePlaceViewport? viewport;
  final double? rating;
  final String? googleMapsUri;
  final String? websiteUri;
  final List<GooglePlaceReview>? reviews;
  final GooglePlaceOpeningHours? regularOpeningHours;
  final GooglePlaceTimeZone? timeZone;
  final List<GooglePlacePhoto>? photos;
  final String? adrFormatAddress;
  final GooglePlaceBusinessStatus businessStatus;
  final GooglePlacePriceLevel priceLevel;
  final List<GooglePlaceAttribution>? attributions;
  final String? iconMaskBaseUri;
  final String? iconBackgroundColor;
  final GooglePlaceOpeningHours? currentOpeningHours;
  final List<GooglePlaceOpeningHours>? currentSecondaryOpeningHours;
  final List<GooglePlaceOpeningHours>? regularSecondaryOpeningHours;
  final GooglePlaceLocalizedText? editorialSummary;
  final GooglePlacePaymentOptions? paymentOptions;
  final GooglePlaceParkingOptions? parkingOptions;
  final List<GooglePlaceSubDestination>? subDestinations;
  final GooglePlaceFuelOptions? fuelOptions;
  final GooglePlaceEvChargeOptions? evChargeOptions;
  final GooglePlaceGenerativeSummary? generativeSummary;
  final List<GooglePlaceContainingPlace>? containingPlaces;
  final GooglePlaceAddressDescriptor? addressDescriptor;
  final GooglePlaceMapsLinks? googleMapsLinks;
  final GooglePlacePriceRange? priceRange;
  final GooglePlaceReviewSummary? reviewSummary;
  final GooglePlaceEvChargeAmenitySummary? evChargeAmenitySummary;
  final GooglePlaceNeighborhoodSummary? neighborhoodSummary;
  final GooglePlaceConsumerAlert? consumerAlert;
  final String? movedPlace;
  final String? movedPlaceId;
  final int? utcOffsetMinutes;
  final int? userRatingCount;
  final bool? takeout;
  final bool? delivery;
  final bool? dineIn;
  final bool? curbsidePickup;
  final bool? reservable;
  final bool? servesBreakfast;
  final bool? servesLunch;
  final bool? servesDinner;
  final bool? servesBeer;
  final bool? servesWine;
  final bool? servesBrunch;
  final bool? servesVegetarianFood;
  final bool? outdoorSeating;
  final bool? liveMusic;
  final bool? menuForChildren;
  final bool? servesCocktails;
  final bool? servesDessert;
  final bool? servesCoffee;
  final bool? goodForChildren;
  final bool? allowsDogs;
  final bool? restroom;
  final bool? goodForGroups;
  final bool? goodForWatchingSports;
  final GooglePlaceAccessibilityOptions? accessibilityOptions;
  final bool? pureServiceAreaBusiness;

  const GooglePlaceDto({
    required this.name,
    required this.id,
    required this.types,
    this.displayName,
    this.primaryType,
    this.primaryTypeDisplayName,
    this.nationalPhoneNumber,
    this.internationalPhoneNumber,
    this.formattedAddress,
    this.shortFormattedAddress,
    this.postalAddress,
    this.addressComponents,
    this.plusCode,
    this.location,
    this.viewport,
    this.rating,
    this.googleMapsUri,
    this.websiteUri,
    this.reviews,
    this.regularOpeningHours,
    this.timeZone,
    this.photos,
    this.adrFormatAddress,
    required this.businessStatus,
    required this.priceLevel,
    this.attributions,
    this.iconMaskBaseUri,
    this.iconBackgroundColor,
    this.currentOpeningHours,
    this.currentSecondaryOpeningHours,
    this.regularSecondaryOpeningHours,
    this.editorialSummary,
    this.paymentOptions,
    this.parkingOptions,
    this.subDestinations,
    this.fuelOptions,
    this.evChargeOptions,
    this.generativeSummary,
    this.containingPlaces,
    this.addressDescriptor,
    this.googleMapsLinks,
    this.priceRange,
    this.reviewSummary,
    this.evChargeAmenitySummary,
    this.neighborhoodSummary,
    this.consumerAlert,
    this.movedPlace,
    this.movedPlaceId,
    this.utcOffsetMinutes,
    this.userRatingCount,
    this.takeout,
    this.delivery,
    this.dineIn,
    this.curbsidePickup,
    this.reservable,
    this.servesBreakfast,
    this.servesLunch,
    this.servesDinner,
    this.servesBeer,
    this.servesWine,
    this.servesBrunch,
    this.servesVegetarianFood,
    this.outdoorSeating,
    this.liveMusic,
    this.menuForChildren,
    this.servesCocktails,
    this.servesDessert,
    this.servesCoffee,
    this.goodForChildren,
    this.allowsDogs,
    this.restroom,
    this.goodForGroups,
    this.goodForWatchingSports,
    this.accessibilityOptions,
    this.pureServiceAreaBusiness,
  });

  factory GooglePlaceDto.fromJson(Map<String, dynamic> json) {
    return GooglePlaceDto(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      types: (json['types'] as List?)?.cast<String>() ?? [],
      displayName: json['displayName'] != null ? GooglePlaceLocalizedText.fromJson(json['displayName']) : null,
      primaryType: json['primaryType'],
      primaryTypeDisplayName: json['primaryTypeDisplayName'] != null
          ? GooglePlaceLocalizedText.fromJson(json['primaryTypeDisplayName'])
          : null,
      nationalPhoneNumber: json['nationalPhoneNumber'],
      internationalPhoneNumber: json['internationalPhoneNumber'],
      formattedAddress: json['formattedAddress'],
      shortFormattedAddress: json['shortFormattedAddress'],
      postalAddress: json['postalAddress'] != null ? GooglePlacePostalAddress.fromJson(json['postalAddress']) : null,
      addressComponents: json['addressComponents'] != null
          ? (json['addressComponents'] as List).map((e) => GooglePlaceAddressComponent.fromJson(e)).toList()
          : null,
      plusCode: json['plusCode'] != null ? GooglePlacePlusCode.fromJson(json['plusCode']) : null,
      location: json['location'] != null ? GooglePlaceLatLng.fromJson(json['location']) : null,
      viewport: json['viewport'] != null ? GooglePlaceViewport.fromJson(json['viewport']) : null,
      rating: (json['rating'] as num?)?.toDouble(),
      googleMapsUri: json['googleMapsUri'],
      websiteUri: json['websiteUri'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((e) => GooglePlaceReview.fromJson(e)).toList()
          : null,
      regularOpeningHours: json['regularOpeningHours'] != null
          ? GooglePlaceOpeningHours.fromJson(json['regularOpeningHours'])
          : null,
      timeZone: json['timeZone'] != null ? GooglePlaceTimeZone.fromJson(json['timeZone']) : null,
      photos: json['photos'] != null
          ? (json['photos'] as List).map((e) => GooglePlacePhoto.fromJson(e)).toList()
          : null,
      adrFormatAddress: json['adrFormatAddress'],
      businessStatus: GooglePlaceBusinessStatusExtension.fromJson(json['businessStatus']),
      priceLevel: GooglePlacePriceLevelExtension.fromJson(json['priceLevel']),
      attributions: json['attributions'] != null
          ? (json['attributions'] as List).map((e) => GooglePlaceAttribution.fromJson(e)).toList()
          : null,
      iconMaskBaseUri: json['iconMaskBaseUri'],
      iconBackgroundColor: json['iconBackgroundColor'],
      currentOpeningHours: json['currentOpeningHours'] != null
          ? GooglePlaceOpeningHours.fromJson(json['currentOpeningHours'])
          : null,
      currentSecondaryOpeningHours: json['currentSecondaryOpeningHours'] != null
          ? (json['currentSecondaryOpeningHours'] as List).map((e) => GooglePlaceOpeningHours.fromJson(e)).toList()
          : null,
      regularSecondaryOpeningHours: json['regularSecondaryOpeningHours'] != null
          ? (json['regularSecondaryOpeningHours'] as List).map((e) => GooglePlaceOpeningHours.fromJson(e)).toList()
          : null,
      editorialSummary: json['editorialSummary'] != null
          ? GooglePlaceLocalizedText.fromJson(json['editorialSummary'])
          : null,
      paymentOptions: json['paymentOptions'] != null
          ? GooglePlacePaymentOptions.fromJson(json['paymentOptions'])
          : null,
      parkingOptions: json['parkingOptions'] != null
          ? GooglePlaceParkingOptions.fromJson(json['parkingOptions'])
          : null,
      subDestinations: json['subDestinations'] != null
          ? (json['subDestinations'] as List).map((e) => GooglePlaceSubDestination.fromJson(e)).toList()
          : null,
      fuelOptions: json['fuelOptions'] != null ? GooglePlaceFuelOptions.fromJson(json['fuelOptions']) : null,
      evChargeOptions: json['evChargeOptions'] != null
          ? GooglePlaceEvChargeOptions.fromJson(json['evChargeOptions'])
          : null,
      generativeSummary: json['generativeSummary'] != null
          ? GooglePlaceGenerativeSummary.fromJson(json['generativeSummary'])
          : null,
      containingPlaces: json['containingPlaces'] != null
          ? (json['containingPlaces'] as List).map((e) => GooglePlaceContainingPlace.fromJson(e)).toList()
          : null,
      addressDescriptor: json['addressDescriptor'] != null
          ? GooglePlaceAddressDescriptor.fromJson(json['addressDescriptor'])
          : null,
      googleMapsLinks: json['googleMapsLinks'] != null ? GooglePlaceMapsLinks.fromJson(json['googleMapsLinks']) : null,
      priceRange: json['priceRange'] != null ? GooglePlacePriceRange.fromJson(json['priceRange']) : null,
      reviewSummary: json['reviewSummary'] != null ? GooglePlaceReviewSummary.fromJson(json['reviewSummary']) : null,
      evChargeAmenitySummary: json['evChargeAmenitySummary'] != null
          ? GooglePlaceEvChargeAmenitySummary.fromJson(json['evChargeAmenitySummary'])
          : null,
      neighborhoodSummary: json['neighborhoodSummary'] != null
          ? GooglePlaceNeighborhoodSummary.fromJson(json['neighborhoodSummary'])
          : null,
      consumerAlert: json['consumerAlert'] != null ? GooglePlaceConsumerAlert.fromJson(json['consumerAlert']) : null,
      movedPlace: json['movedPlace'],
      movedPlaceId: json['movedPlaceId'],
      utcOffsetMinutes: json['utcOffsetMinutes'],
      userRatingCount: json['userRatingCount'],
      takeout: json['takeout'],
      delivery: json['delivery'],
      dineIn: json['dineIn'],
      curbsidePickup: json['curbsidePickup'],
      reservable: json['reservable'],
      servesBreakfast: json['servesBreakfast'],
      servesLunch: json['servesLunch'],
      servesDinner: json['servesDinner'],
      servesBeer: json['servesBeer'],
      servesWine: json['servesWine'],
      servesBrunch: json['servesBrunch'],
      servesVegetarianFood: json['servesVegetarianFood'],
      outdoorSeating: json['outdoorSeating'],
      liveMusic: json['liveMusic'],
      menuForChildren: json['menuForChildren'],
      servesCocktails: json['servesCocktails'],
      servesDessert: json['servesDessert'],
      servesCoffee: json['servesCoffee'],
      goodForChildren: json['goodForChildren'],
      allowsDogs: json['allowsDogs'],
      restroom: json['restroom'],
      goodForGroups: json['goodForGroups'],
      goodForWatchingSports: json['goodForWatchingSports'],
      accessibilityOptions: json['accessibilityOptions'] != null
          ? GooglePlaceAccessibilityOptions.fromJson(json['accessibilityOptions'])
          : null,
      pureServiceAreaBusiness: json['pureServiceAreaBusiness'],
    );
  }

  Place toDomain() {
    return Place(
      id: id,
      name: displayName?.text ?? "Place name unavailable",
      location: GeoPoint(latitude: location?.latitude ?? 0.0, longitude: location?.longitude ?? 0.0),
      categories: types,
      address: formattedAddress ?? '',
    );
  }
}
