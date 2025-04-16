import 'package:flutter/material.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';
import 'package:speedpilot/services/WebSocketManager.dart';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

/// A Device List with all possible vehicle options is beeing Implemented in this file
/// This File will create a list of Cards aligned vertically
/// By pressing the Card with the name "SpeedPilot", the system tries to connect to the WebSocket
/// While that the Lightning Button inside the card will turn orange
/// If the connection is successful within 20 seconds, the Lightning Button will turn green and a Navigation to the 
/// MapPage in /map_page/map_scrolling_page.dart will be performed
/// If the connection is not possible an errorlog will pop up 
/// If the Device is connected to the WebSocket, the WebSocket will send a message to the Device which confirms the connection

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
  List<bool> isAborted = [false];
  Timer? connectionTimer;

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
                });
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> attemptConnection() async {
    bool connected = false;
    Timer timeout = Timer(Duration(seconds: 20), (){
      if (!connected) {
        showErrorDialog(context, "Es ist ein Fehler aufgetreten, bitte überprüfen Sie ob das Auto hochgefahren ist",0);
      }
    });
    connectionTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (!connected) {
        try {
          await WebSocketManager().connect('ws://localhost:9090');
          setState(() {
            isConnected = [true];
          });
          connected = true;
          timer.cancel();
          timeout.cancel();
          WebSocketManager().receiveMessage((message) {
            final data = jsonDecode(message);
            if (data["type"] == "command") {
              print("Kommando vom Server: ${data["speed"]}, ${data["status"]} ,${data["content"]}");
            }
            else{
              print("fehler"); 
            }
              
          });
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
