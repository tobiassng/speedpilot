import 'package:flutter/material.dart';
import 'features/device_list.dart';
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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(250, 25, 25, 25),
          leading: IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              WebSocketManager().closeConnection();
            },
          ),
        ),
        body: Devices());
  }
}
