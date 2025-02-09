import 'package:flutter/material.dart';
import './features/map_carousel.dart';
import 'package:flutter/services.dart';
import 'package:speedpilot/starting_page/starting_page.dart';

class MapScrolling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/PfuschMobil.png'), context);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 25, 25, 25),
      body: Stack(
        children: <Widget>[
          CustomCarousel(),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => StartingPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

