import 'package:flutter/material.dart';

class MapDrivingPage extends StatelessWidget {
  final String imagePath;

  // Korrigierter Konstruktor mit Initialisierung und Schlüssel
  const MapDrivingPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driving Page'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
