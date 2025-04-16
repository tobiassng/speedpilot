import 'package:flutter/material.dart'; 
import "package:speedpilot/starting_page/starting_page.dart";
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
            child: SettingsList(),    
          ),
          Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.navigate_before,color:Colors.white),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => StartingPage()));
              },
      ))]
        ),
        backgroundColor: const Color.fromARGB(200, 25, 25, 25),
    );
    
  }
}
