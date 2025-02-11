import 'package:flutter/material.dart';
import './features/map_carousel.dart';
import 'package:flutter/services.dart';
import 'package:speedpilot/starting_page/starting_page.dart';

class MapScrolling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialisiere Widgets und setze die Ausrichtung
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 25, 25, 25),
      body: Stack(
        children: <Widget>[
          CustomCarousel(),
          Positioned(
            top: 50,
            left: 20,
            child: FloatingActionButton(
              child: Icon(Icons.navigate_before, color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 35, 35, 35),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartingPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
