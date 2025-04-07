import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:speedpilot/services/WebSocketManager.dart';

class JoystickPage extends StatefulWidget {
  @override
  _JoystickPageState createState() => _JoystickPageState();
}

class _JoystickPageState extends State<JoystickPage> {
  @override
  Widget build(BuildContext context) {
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
            WebSocketManager().sendDrivingData(details.x, details.y);
            },
        ),
      
    );
  }
}
