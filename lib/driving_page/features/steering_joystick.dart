import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:speedpilot/services/WebSocketManager.dart';

class SteeringJoystickPage extends StatefulWidget {
  const SteeringJoystickPage({super.key});

  @override
  _JoystickPageState createState() => _JoystickPageState();
}

class _JoystickPageState extends State<SteeringJoystickPage> {
  @override
  Widget build(BuildContext context) {
    return Joystick(
      mode: JoystickMode.horizontal,
      base: JoystickBase(
        mode: JoystickMode.horizontal,
        decoration: JoystickBaseDecoration(
            drawOuterCircle: false,
            color: Color.fromARGB(250, 25, 25, 25),
            drawInnerCircle: false,
            drawMiddleCircle: false),
      ),
      stick: JoystickStick(
        decoration: JoystickStickDecoration(
          color: Colors.red,
        ),
      ),
      listener: (StickDragDetails details) {
        WebSocketManager().updateAngle(details.x);
      },
    );
  }
}
