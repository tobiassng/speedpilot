import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import './occupancy_grid.dart';

class LidarScreen extends StatefulWidget {
  const LidarScreen({super.key});
  @override
  State<LidarScreen> createState() => _LidarScreenState();
}

class _LidarScreenState extends State<LidarScreen> {
  OccupancyGrid? grid;

  @override
  void initState() {
    super.initState();
    loadLidarData();
  }

  Future<void> loadLidarData() async {
    try {
      String jsonStr = await rootBundle
          .loadString('assets/lidar_data/occupancy_grid_example.json');
      Map<String, dynamic> jsonMap = json.decode(jsonStr);
      setState(() {
        grid = OccupancyGrid.fromJson(jsonMap);
      });
    } catch (e, stacktrace) {
      print("Fehler beim Laden der JSON-Datei: $e");
      print(stacktrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (grid == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: GridView.builder(
        itemCount: grid!.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: grid!.mapMetaData.width,
        ),
        itemBuilder: (context, index) {
          int value = grid!.data[index];
          Color color;

          if (value == -1) {
            color = const Color.fromARGB(255, 0, 0, 0);
          } else if (value == 0) {
            color = const Color.fromARGB(255, 0, 0, 0);
          } else {
            color = Colors.white;
          }

          return Container(
            color: color,
            margin: const EdgeInsets.all(0.1),
          );
        },
      ),
    );
  }
}
