import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        color:
            const Color.fromARGB(200, 50, 50, 50), // Setze die Hintergrundfarbe
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 5
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined, color: Colors.white),
            label: "Map",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.white),
              label: "Settings"),
        ],
        backgroundColor: Colors
            .transparent, // Transparent, da Hintergrundfarbe im Container gesetzt wird
        selectedItemColor: Colors.white, // Farbe des ausgewählten Elements
        unselectedItemColor:
            Colors.grey, // Farbe der nicht ausgewählten Elemente
      ),
    );
  }
}
