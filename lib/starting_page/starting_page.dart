import 'package:flutter/material.dart';
import './features/device_list.dart';
import './features/navigationbar.dart';
import 'package:flutter/services.dart';

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/PfuschMobil.png'), context);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: Devices(),

      backgroundColor: const Color.fromARGB(
          200, 25, 25, 25),
    );
  }
}
