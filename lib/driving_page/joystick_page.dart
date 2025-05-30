import 'package:flutter/material.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';
import './features/tachometer.dart';
import 'package:flutter/services.dart';
import './features/steering_joystick.dart';
import './features/gas_joystick.dart';
import 'package:speedpilot/settings_page/settings_page.dart';
import '../driving_page/features/lidar_data.dart';
import '../driving_page/features/lidar_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class JoystickPage extends StatelessWidget {
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
              child: Tachometer(),
          
          ),
          // Align(
          // alignment: Alignment.topCenter,
          //  child: Container(
          //   margin: const EdgeInsets.only(
          //      top: 10,
          //    ),
          //    height: 225,
          //    width: 225,
          //    child: LidarScreen())),
          Positioned(
          top: 20,
          right: 50,
          child: IconButton(
            icon: Icon(Icons.settings,color:Colors.white),
            onPressed: () async {
              WidgetsFlutterBinding.ensureInitialized();
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight
              ]);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
                },
          )),
          Positioned(
            bottom: 7,
            right: 40,
            
              child: SteeringJoystickPage()),
          // FloatingActionButton oben links
        
          Positioned(
            bottom: 10,
            left: 40,
              child: GasJoystickPage()
          ),
          Positioned(
            top: 20,
            left: 50,
            child: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('gyro', false); // Standardmäßig auf false setzen
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
         
          
        
        ],
      ),
    );
  }
}
