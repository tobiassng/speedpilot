import 'package:flutter/material.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';
import 'package:speedpilot/services/WebSocketManager.dart';
import 'dart:async';

class Devices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Options();
  }
}

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  final List<String> options = [
    "SpeedPilot", // Beispiel-Option
  ];
  List<bool> hasBeenPressed = [false];
  List<bool> isConnected = [false];
  Timer? connectionTimer;

  Future<void> attemptConnection() async {
    bool connected = false;
    connectionTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (!connected) {
        try {
          await WebSocketManager().connect('ws://localhost:9090');
          setState(() {
            isConnected = [true];
          });
          connected = true;
          print("WebSocket erfolgreich verbunden");
          timer.cancel();

          // Nach erfolgreicher Verbindung, die Seite wechseln
          if (connected) {
            await Future.delayed((Duration(seconds: 2)));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScrolling()),
            );
          }
        } catch (error) {
          print("Fehler beim Verbinden: $error");
        }
      }
    });
  }

  @override
  void dispose() {
    connectionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          height: MediaQuery.of(context).size.height * 0.175,
          child: Card(
            color: const Color.fromARGB(200, 35, 35, 35),
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: InkWell(
              onTap: () async {
                // Versuche die Verbindung aufzubauen
                await attemptConnection();

                setState(() {
                  if (!hasBeenPressed[index]) {
                    hasBeenPressed[index] = true;
                  }
                });
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: isConnected[index]
                                ? Colors.green
                                : (hasBeenPressed[index] ? Colors.orange : Colors.red),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: isConnected[index]
                                    ? Colors.green.withOpacity(0.8)
                                    : (hasBeenPressed[index]
                                        ? Colors.orange.withOpacity(0.8)
                                        : Colors.red.withOpacity(0.8)),
                                spreadRadius: 10,
                                blurRadius: 20,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          options[index],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/PfuschMobil.png',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
