import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:speedpilot/services/WebSocketManager.dart';

/// In the class SteeringJoystickPage the Joystick for driving backward and forward is being implemented
/// The Information about the rash of the Joystick ist send to the WebSocket with following JSON Structure:
/// {"command":"move", "speed":-1.0 to 1.0, "angle":-1.0 to 1.0}
/// The "command" serves as a key for identification and the "angle" contains the horizontal rash of the SteeringJoystick, which is beeing
/// created in this class

class SteeringJoystickPage extends StatefulWidget {
  @override
  _SteeringJoystickPageState createState() => _SteeringJoystickPageState();
}

class _SteeringJoystickPageState extends State<SteeringJoystickPage> {
  @override
  Widget build(BuildContext context) {
    // create horizontal rashing Joystick
    return Container(
        child: Joystick(
          mode: JoystickMode.horizontal,
          base: JoystickBase(
            mode: JoystickMode.horizontal,
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
            // send Joystick Data to the WebSocket
            WebSocketManager().sendDrivingData('move', details.x, details.y);
            
            },
        ),
      
    );
  }
}
