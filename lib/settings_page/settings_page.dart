import 'package:flutter/material.dart';
import 'package:speedpilot/driving_page/no_map_driving_page.dart'; 
import './features/settings_list.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: SettingsList()),    
          ),
          Positioned(
            top: 20,
            left: 50,
            child: IconButton(
              icon: Icon(Icons.navigate_before,color:Colors.white),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoMapDrivingPage()));
              },
      ))]
        ),
        backgroundColor: const Color.fromARGB(200, 25, 25, 25),
    );
    
  }
}
