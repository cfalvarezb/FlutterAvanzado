import 'package:flutter/material.dart';
import 'package:maps_app/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 350,
      height: 150,
      child: CustomPaint(
        painter: StartMarkerPainter(
          destination: 'Mi casa',
          minutes: 2
        ),
      ),
    );
  }
}