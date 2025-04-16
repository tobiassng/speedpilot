import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The MapDriving Page class
class MapDrivingPage extends StatelessWidget {
  final String imagePath;

  const MapDrivingPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
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
