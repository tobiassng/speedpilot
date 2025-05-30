import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:speedpilot/services/WebSocketManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GasJoystickPage extends StatefulWidget {
  @override
  _GasJoystickPageState createState() => _GasJoystickPageState();
}
class _GasJoystickPageState extends State<GasJoystickPage> {
  Future<void> _getSpeedData(double value) async {
     final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('speed', value);
  }
  double speedy = 0.0;
  @override
  Widget build(BuildContext context) {
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

            WebSocketManager().updateSpeed(-details.y);
            speedy = details.y * -1 * 8;
            _getSpeedData(speedy);
           },
        ),
      
    );
  }
}
