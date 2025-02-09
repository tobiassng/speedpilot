import 'package:flutter/material.dart';
import './features/map_carousel.dart';

class MapScrolling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Maps', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(200, 35, 35, 35),
        ),
        backgroundColor: const Color.fromARGB(200, 25, 25, 25),
        body: CustomCarousel());
  }
}
