import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:speedpilot/services/WebSocketManager.dart';
import 'dart:convert';

/// In the class GasJoystickPage the Joystick for driving backward and forward is being implemented
/// The Information about the rash of the Joystick ist send to the WebSocket with following JSON Structure:
/// {"command":"move", "speed":-1.0 to 1.0, "angle":-1.0 to 1.0}
/// The "command" serves as a key for identification and the "speed" contains the vertical rash of the GasJoystick which is beeing
/// created in this class

class GasJoystickPage extends StatefulWidget {
  @override
  _GasJoystickPageState createState() => _GasJoystickPageState();
}
class _GasJoystickPageState extends State<GasJoystickPage> {
  @override
  Widget build(BuildContext context) {
    // create vertical rashing Joystick
    return Container(
        child: Joystick(
          mode: JoystickMode.vertical,
          base: JoystickBase(
            mode: JoystickMode.vertical,
            decoration: JoystickBaseDecoration(
              drawOuterCircle: false,
              color: Color.fromARGB(200, 25, 25, 25),
              drawInnerCircle: false,
              drawMiddleCircle: false
            ),
          ),
          stick: JoystickStick(
            decoration: JoystickStickDecoration(
              color: Colors.red,
            ),
          ), listener: (StickDragDetails details) { 
            //send data about Joystick to WebSocket
            WebSocketManager().sendDrivingData('move',details.x, details.y);
          
           },
        ),
      
    );
  }
}
