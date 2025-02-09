import 'package:flutter/material.dart';
import 'package:speedpilot/map_page/map_scrolling_page.dart';

class Devices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Options(),
      backgroundColor: const Color.fromARGB(200, 25, 25, 25),
    );
  }
}

class Options extends StatelessWidget {
  final List<String> options = [
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Container(
            height: 150,
            child: Card(
              color: const Color.fromARGB(200, 35, 35, 35),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScrolling()),
                    );
                  }
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
                              color: Colors.red, // Farbe des Punktes
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.8),
                                  spreadRadius: 10,
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                )
                              ], // Leuchtfarbe
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
                        './assets/images/PfuschMobil.png',
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
