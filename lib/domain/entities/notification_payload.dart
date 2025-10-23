import 'dart:convert';

enum NotificationType { proximity, event }

// --- 1. Base class ---
sealed class NotificationPayload {
  final NotificationType type;

  const NotificationPayload(this.type);

  /// Factory global pour sérialiser le JSON "type" vers le bon sous-modèle
  factory NotificationPayload.fromJson(String source) {
    final map = jsonDecode(source) as Map<String, dynamic>;
    switch (map['type']) {
      case 'proximity':
        return ProximityNotificationPayload.fromMap(map);
      case 'event':
        return EventNotificationPayload.fromMap(map);
      // Ajoute ici tes autres types
      default:
        throw Exception('Type inconnu : ${map['type']}');
    }
  }

  Map<String, dynamic> toJson();

  String toRawJson() => jsonEncode(toJson());
}

class ProximityNotificationPayload extends NotificationPayload {
  final String stationId;

  ProximityNotificationPayload({required this.stationId}) : super(NotificationType.proximity);

  factory ProximityNotificationPayload.fromMap(Map<String, dynamic> map) {
    if (map['stationId'] == null) {
      throw ArgumentError('stationId doit être renseigné pour type proximity');
    }
    return ProximityNotificationPayload(stationId: map['stationId']);
  }

  @override
  Map<String, dynamic> toJson() => {'type': type.name, 'stationId': stationId};
}

class EventNotificationPayload extends NotificationPayload {
  final String eventId;

  EventNotificationPayload({required this.eventId}) : super(NotificationType.event);

  factory EventNotificationPayload.fromMap(Map<String, dynamic> map) {
    if (map['eventId'] == null) {
      throw ArgumentError('eventId doit être renseigné pour type event');
    }
    return EventNotificationPayload(eventId: map['eventId']);
  }

  @override
  Map<String, dynamic> toJson() => {'type': type, 'eventId': eventId};
}
