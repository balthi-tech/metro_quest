import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MetroLineColors {
  static double getColorHueFromColor(Color? lineColor) {
    final hslColor = HSLColor.fromColor(lineColor ?? Colors.black);

    return hslColor.hue;
  }

  static Future<BitmapDescriptor> createStyledMarker(Color color, {int size = 100}) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final center = Offset(size / 2, size / 2);
    final radius = size / 2;

    // Fond dégradé radial du cercle (du blanc au color)
    final gradient = RadialGradient(
      colors: [color.withValues(alpha: 0.9), color],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..shader = gradient.createShader(rect);

    // Cercle principal avec dégradé
    canvas.drawCircle(center, radius, paint);

    // Cercle intérieur lumineux
    final innerCirclePaint = Paint()..color = Colors.white.withValues(alpha: 0.4);

    canvas.drawCircle(center, radius * 0.5, innerCirclePaint);

    // Bordure blanche
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size * 0.1;

    canvas.drawCircle(center, radius - borderPaint.strokeWidth / 2, borderPaint);

    // Fin du dessin
    final picture = recorder.endRecording();
    final img = await picture.toImage(size, size);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Erreur lors de la création du marker');
    }

    final pngBytes = byteData.buffer.asUint8List();
    return BitmapDescriptor.bytes(pngBytes);
  }
}
