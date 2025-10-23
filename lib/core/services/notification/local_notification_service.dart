import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/domain/entities/notification_payload.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
    'notification(${notificationResponse.id}) action tapped: '
    '${notificationResponse.actionId} with'
    ' payload: ${notificationResponse.payload}',
  );
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  void Function(String? payload) onNotificationResponse;

  NotificationService({required this.onNotificationResponse});

  Future<void> init() async {
    // Configuration Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuration iOS
    final iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      // onDidReceiveLocalNotification: (id, title, body, payload) async {}, // optionnel
    );

    // Paramètres d'initialisation cross-plateforme
    final initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // response.notificationResponseType
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          Log.d('Notification payload: $payload');

          onNotificationResponse(payload);

          // Gestion de la sélection notification (navigation, etc)
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    NotificationPayload? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentSound: true,
    );

    const platformDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _plugin.show(0, title, body, platformDetails, payload: payload?.toRawJson());
  }
}
