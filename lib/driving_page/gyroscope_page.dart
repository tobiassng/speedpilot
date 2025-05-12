import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';
import 'package:speedpilot/settings_page/settings_page.dart';
import './features/tachometer.dart';
import './features/gyroscope_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GyroscopePage extends StatelessWidget {
  final String imagePath;

  const GyroscopePage({Key? key, required this.imagePath}) : super(key: key);

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
         //Align(alignment: Alignment.topCenter, child: Container(
          //height: 250,
          //width: 250,
          //child: getGyroscope())),
          
        
        ],
      ),
      
    );
  }
}
