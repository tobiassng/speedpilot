import 'package:flutter/material.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';
import './features/tachometer.dart';
import 'package:flutter/services.dart';
import './features/steering_joystick.dart';
import './features/gas_joystick.dart';

class NoMapDrivingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 25, 25, 25),
      body: Stack(
        children: <Widget>[
          // Tachometer bleibt unten und zentriert
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Tachometer(),
            ),
          ),
          Positioned(
            bottom: 7,
            right: 40,
            
              child: JoystickPage()),
          // FloatingActionButton oben links
        
          Positioned(
            bottom: 10,
            left: 40,
              child: GasJoystickPage()
          ),
          Positioned(
            top: 20,
            left: 50,
            child: FloatingActionButton(
              child: Icon(Icons.navigate_before, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 35, 35, 35),
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScrolling()),
                );
              },
            ),
          ),
          
          // Hier kannst du weitere Widgets hinzufügen, die platziert werden sollen
        
        ],
      ),
    );
  }
}
