import 'package:flutter/material.dart';
import './features/device_list.dart';
import './features/navigationbar.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      appBar: AppBar(
          title: Text('All Devices', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey.shade900),
      body: Devices(),

      backgroundColor: const Color.fromARGB(
          200, 25, 25, 25), // Hintergrundfarbe des Scaffold
    );
  }
}
