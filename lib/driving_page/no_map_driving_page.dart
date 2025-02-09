import 'package:flutter/material.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';
import './features/tachometer.dart';
import 'package:flutter/services.dart';

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
          Tachometer(),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              child: Icon(Icons.navigate_before, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 35, 35, 35),
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapScrolling()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
