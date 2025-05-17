import 'package:flutter/material.dart';
import './features/map_carousel.dart';
import 'package:flutter/services.dart';
import 'package:speedpilot/starting_page/starting_page.dart';
import 'package:speedpilot/services/WebSocketManager.dart';

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
      backgroundColor: const Color.fromARGB(250, 25, 25, 25),
      body: Stack(
        children: <Widget>[
          CustomCarousel(),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: () {
                WebSocketManager().closeConnection();
                Navigator.push(
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
