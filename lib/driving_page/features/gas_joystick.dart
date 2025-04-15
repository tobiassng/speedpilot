import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:speedpilot/services/WebSocketManager.dart';


/// The class GasJoyStickPage contains the Joystick which is used to control the speed of the SpeedPilot Car
/// The JoyStick Information are sent via Json with following syntax: {'x': bool, 'y': bool}

class GasJoystickPage extends StatefulWidget {
  @override
  _GasJoystickPageState createState() => _GasJoystickPageState();
}
class _GasJoystickPageState extends State<GasJoystickPage> {
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
            WebSocketManager().sendDrivingData(details.x, details.y);
            print("${details.y} ${details.x}",);
           },
        ),
      
    );
  }

}
