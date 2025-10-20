import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/features/station/logic/station_controller.dart';

class MetroStationListTile extends StatefulWidget {
  final MetroStation station;
  final StationController stationController;
  final bool isCheckable;
  const MetroStationListTile({
    super.key,
    required this.station,
    required this.stationController,
    required this.isCheckable,
  });

  @override
  State<MetroStationListTile> createState() => _MetroStationListTileState();
}

class _MetroStationListTileState extends State<MetroStationListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.station.name),
      subtitle: Text(
        'Distance: ${widget.station.distanceFromUser != null ? '${widget.station.distanceFromUser!.toStringAsFixed(2)} km' : 'Inconnue'}',
      ),
      leading: CircleAvatar(
        backgroundColor: widget.station.lineColor ?? Colors.grey,
        child: Text(
          widget.station.lineName.length == 1 ? widget.station.lineName : widget.station.lineName.substring(0, 2),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      trailing: widget.isCheckable
          ? Checkbox(
              value: widget.station.visited,
              onChanged: (value) async {
                await widget.stationController.visitStation(widget.station.id, value ?? false);
              },
            )
          : null,
      onTap: () {
        context.push('/station/${widget.station.id}');
      },
    );
  }
}
