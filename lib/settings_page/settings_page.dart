import 'package:flutter/material.dart'; 
import './features/settings_list.dart';
import '../driving_page/no_map_driving_page.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SettingsList(),    
          ),
          Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.navigate_before,color:Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NoMapDrivingPage()));
              },
      ))]
        ),
        backgroundColor: const Color.fromARGB(200, 25, 25, 25),
    );
    
  }
}
