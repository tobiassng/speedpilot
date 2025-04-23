import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; 

class getGyroscope extends StatefulWidget {
  @override
  State<getGyroscope> createState() => _getGyroscope(); 
}

class _getGyroscope extends State<getGyroscope> {
  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;
  @override
   void initState() {
    super.initState();

    // Listen to gyroscope data stream
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroX = event.x;
        _gyroY = event.y;
        _gyroZ = event.z;
      });
    });
  }
  void normalizeGyroscopeData() {
   
  }
  @override
  Widget build(BuildContext context) {
   return Container(
        height: 100,
        width:100,
        color: const Color.fromARGB(200, 25, 25, 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gyroscope Data:',
             style: TextStyle(
              color: Colors.white,
             )), // Display a label
            Text('X: $_gyroX',
            style: TextStyle(
              color: Colors.white
             )), // Display gyroscope X data
            Text('Y: $_gyroY',
            style: TextStyle(
              color: Colors.white
             )), // Display gyroscope Y data
            Text('Z: $_gyroZ',
            style: TextStyle(
              color: Colors.white
             )), // Display gyroscope Z data
          ],
        ));
  }
}
