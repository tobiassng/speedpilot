import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; 
import 'package:motion_sensors/motion_sensors.dart';
import 'package:speedpilot/services/WebSocketManager.dart';

class getGyroscope extends StatefulWidget {
  @override
  State<getGyroscope> createState() => _getGyroscope(); 
}

class _getGyroscope extends State<getGyroscope> {
  double _motionPitch = 0.0;
  double _motionRoll = 0.0;
  double _motionYaw = 0.0;
  late final StreamSubscription<OrientationEvent> _orientationSubscription;
  @override
   void initState() {
    super.initState();

    // Listen to Motion data stream
     _orientationSubscription = motionSensors.orientation.listen((OrientationEvent event) {
      setState(() {
        _motionPitch = event.pitch;
        _motionRoll = event.roll;
        _motionYaw = event.yaw;
      });
      limitMotion();
      WebSocketManager().sendDrivingData("move", _motionRoll, _motionPitch);

    });
  }
  
  void limitMotion() {
    if (_motionPitch >= 1.0){
      _motionPitch = 1.0;
    } 
    else if (_motionPitch <= -1.0){
      _motionPitch = -1.0;
    }
    if (_motionRoll >= 1.0){
      _motionRoll = 1.0;
    }
    else if (_motionRoll <= -1.0){
      _motionRoll = -1.0;
    }
  } 
  @override
  void dispose() {
  _orientationSubscription.cancel();
    super.dispose();
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
            Text('Motion Data:',
             style: TextStyle(
              color: Colors.white,
             )), 
            Text('Pitch: $_motionPitch',
            style: TextStyle(
              color: Colors.white
             )), 
            Text('Roll: $_motionRoll',
            style: TextStyle(
              color: Colors.white
             )), 
            Text('Yaw: $_motionYaw',
            style: TextStyle(
              color: Colors.white
             )), 
          ],
        ));
  
  }
}
