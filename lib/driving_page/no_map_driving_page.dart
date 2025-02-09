import 'package:flutter/material.dart';
import './features/tachometer.dart';

class NoMapDrivingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driving Page'),
          backgroundColor: const Color.fromARGB(200, 35, 35, 35),
        ),
        body: Tachometer(),
        backgroundColor: Color.fromARGB(200, 25, 25, 25));
  }
}
