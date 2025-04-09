import 'package:flutter/material.dart';

class SettingsList extends StatefulWidget {
  @override
  _SettingsList createState() => _SettingsList();
}

class _SettingsList extends State<SettingsList> {
  final List<CardOption> settings = [
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
   
    ),
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
    ),
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
    ),
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
    ),
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
    ),
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
    ),
    CardOption(
      title: "Steering",
      color: const Color.fromARGB(200, 35, 35, 35),
      fontColor: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settings.length,
      itemBuilder: (context, index) {
        final setting = settings[index];
        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          height: MediaQuery.of(context).size.height * 0.075, // Größe der Karten angepasst
          child: Card(
            color: setting.color,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Texte links ausrichten
                children: [
                  Text(
                    setting.title,
                    style: TextStyle(
                      color: setting.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardOption {
  final String title;
  final Color color;
  final Color fontColor;

  CardOption({
    required this.title,
    required this.color,
    required this.fontColor,

  });
}
