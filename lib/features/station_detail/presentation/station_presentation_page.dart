import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/entities/notification_payload.dart';
import 'package:metro_quest/domain/entities/place_entity.dart';
import 'package:metro_quest/domain/entities/place_filter_category_entity.dart';
import 'package:metro_quest/features/active_navigation/logic/active_navigation_provider.dart';
import 'package:metro_quest/features/open_in_map/presentation/widgets/open_in_map_button.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/providers/google_place_provider.dart';
import 'package:metro_quest/shared/providers/local_notification_service_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';

class StationDetailPage extends ConsumerStatefulWidget {
  final String stationId;
  const StationDetailPage({required this.stationId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends ConsumerState<StationDetailPage> {
  // _places list to hold fetched places

  final List<Place> _places = [];

  @override
  Widget build(BuildContext context) {
    final filteredStationAsync = ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(id: widget.stationId),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
        title: Text('Détails de la station'),
      ),
      body: asyncValueWrapper(
        asyncValue: filteredStationAsync,
        data: (stations) {
          if (stations.isEmpty) {
            return Center(child: Text('Station non trouvée'));
          }

          final station = stations.first;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  station.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                Text('ID de la station: ${station.id}'),
                SizedBox(height: 8),
                Text('Nom de la ligne: ${station.lineName}'),
                SizedBox(height: 8),
                OpenInMapButton(
                  destinationTitle: station.name,
                  geoPoint: station.geoPoint,
                  onMapLaunched: () {
                    ref.read(activeNavigationProvider.notifier).startNavigationTo(station);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Log.d(station.geoPoint.toString());

                    // Trigger a test proximity notification
                    ref
                        .read(notificationServiceProvider)
                        .showNotification(
                          title: 'Proximité de la station',
                          body: 'Vous êtes proche de la station ${station.name}',
                          payload: ProximityNotificationPayload(
                            stationId: station.id,
                          ),
                        );

                    context.pop();
                  },
                  child: Text("TEST Notification Proximité"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final latitude = station.geoPoint.latitude;
                    final longitude = station.geoPoint.longitude;
                    final category = PlaceCategory.histoireCulture;

                    Log.d(
                      "Searching nearby places for station ${station.name} at ($latitude, $longitude) in category $category",
                    );

                    final places = await ref
                        .read(getNearbyPlacesUseCaseProvider)
                        .execute(latitude: latitude, longitude: longitude, category: category, radius: 200);

                    Log.d("Found ${places.length} places nearby:");

                    setState(() {
                      _places.clear();
                      _places.addAll(places);
                    });
                  },
                  child: Text("TEST Google Places"),
                ),
                if (_places.isEmpty) ...[
                  SizedBox(height: 16),
                  Text(
                    'Aucun lieu à proximité chargé.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                if (_places.isNotEmpty) ...[
                  SizedBox(height: 16),
                  Text(
                    'Lieux à proximité:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],

                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final place = _places[index];
                      return ListTile(
                        title: Text(place.name),
                        subtitle: Text(place.address),
                        trailing: OpenInMapButton(
                          destinationTitle: place.name,
                          geoPoint: place.location,
                        ),
                      );
                    },
                    itemCount: _places.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
