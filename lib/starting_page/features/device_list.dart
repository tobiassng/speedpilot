import 'package:flutter/material.dart';
import 'package:speedpilot/starting_page/features/user_dialogue.dart';
import "package:speedpilot/models/card_list.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:speedpilot/services/WebSocketManager.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';

class Devices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DeviceOptions();
  }
}

class DeviceOptions extends StatefulWidget {
  const DeviceOptions({Key? key}) : super(key: key);
  _DeviceOptions createState() => _DeviceOptions();
}

class _DeviceOptions extends State<DeviceOptions> {
  List<CardList> deviceCards = [];

  List<bool> hasBeenPressed = [false];
  List<bool> isConnected = [false];
  List<bool> isAborted = [false];

  Timer? connectionTimer;

  Future<void> loadDeviceCards() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('deviceCards');

    if (jsonList != null) {
      setState(() {
        deviceCards = jsonList
            .map((item) => CardList.fromJson(json.decode(item)))
            .toList();
      });
    }
  }

  Future<void> saveDeviceCards() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        deviceCards.map((device) => json.encode(device.toJson())).toList();
    await prefs.setStringList('deviceCards', jsonList);
  }

  void showErrorDialog(BuildContext context, String message, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(200, 35, 35, 35),
          title: Text(
            'Fehler',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isAborted[index] = true;
                  isConnected[index] = false;
                  hasBeenPressed[index] = false;
                });
                WebSocketManager().closeConnection();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> attemptConnection(int index) async {
    bool connected = false;

    Timer timeout = Timer(Duration(seconds: 20), () {
      if (!connected) {
        connectionTimer?.cancel();
        showErrorDialog(
            context,
            "Überprüfen Sie, ob ihre URL dem Schema ws://x.x.x.x entspricht und ob das Auto vollständig hochgefahren ist. Versuchen Sie es anschließend erneut",
            0);
      }
    });

    connectionTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (!connected) {
        try {
          String url = deviceCards[index].ipaddress;
          await WebSocketManager().connect(url);
          print(
              "Verbindungsaufbau zu ${deviceCards[index].ipaddress} gestartet");
          connected = true;
          timer.cancel();
          timeout.cancel();
          setState(() {
            isConnected[0] = true;
          });

          await Future.delayed(Duration(seconds: 1));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapScrolling()),
          );

          // Und erst jetzt Nachrichten empfangen
          WebSocketManager().receiveMessage((message) async {
            final data = jsonDecode(message);
            if (data["type"] == "command") {
              print(
                  "Kommando vom Server: ${data["speed"]}, ${data["status"]}, ${data["content"]}");
            } else {
              print("Ungültige Nachricht vom Server");
            }
          });
        } catch (error) {
          print("Fehler beim Verbinden: $error");
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadDeviceCards();
  }

  void addDeviceData(CardList device) {
    setState(() {
      deviceCards.add(device);
    });
    saveDeviceCards();
  }

  void dispose() {
    connectionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showUserDialogue() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(250, 25, 25, 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: AddUserDialogue(addDeviceData),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 25, 25, 25),
      floatingActionButton: FloatingActionButton(
        onPressed: showUserDialogue,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: deviceCards.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
              ),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Card(
                color: const Color.fromARGB(250, 35, 35, 35),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onTap: () async {
                    await attemptConnection(index);
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        width: 24.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.8),
                              spreadRadius: 10,
                              blurRadius: 20,
                              offset: const Offset(0, 0),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            deviceCards[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            deviceCards[index].ipaddress,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(right: 0),
                        child: Image.asset('assets/images/PfuschMobil.png'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            deviceCards.removeAt(index);
                            saveDeviceCards();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
