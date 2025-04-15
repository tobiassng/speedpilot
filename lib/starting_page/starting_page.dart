import 'package:flutter/material.dart';
import './features/device_list.dart';
import 'package:flutter/services.dart';
import 'package:speedpilot/settings_page/settings_page.dart';
import 'package:speedpilot/services/WebSocketManager.dart';


class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Devices(),    
          ),
           Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.logout,color:Colors.white),
              onPressed: () {
                WebSocketManager().closeConnection();
              },
      )),
        ],
      ),
      backgroundColor: const Color.fromARGB(200, 25, 25, 25),
    );
  }
}
