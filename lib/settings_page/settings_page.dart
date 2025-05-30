import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedpilot/driving_page/gyroscope_page.dart';
import 'package:speedpilot/driving_page/joystick_page.dart';
import './features/settings_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../driving_page/gyroscope_page.dart';

// Dummy Alternative Page
class AlternativePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Alternative Seite", style: TextStyle(color: Colors.white))),
      backgroundColor: Colors.black,
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _switchState = false;
  
  get images => null;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _switchState = prefs.getBool('gyro') ?? false;
    });
  }

  void _onBeforePressed() {
    if (!_switchState) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => JoystickPage()),
      );
    } else {
      Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
              builder: (_) => GyroscopePage(imagePath: '',
                )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(200, 25, 25, 25),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: SettingsList(onSwitchChanged: (val) {
                _switchState = val;
              }),
            ),
          ),
          Positioned(
            top: 20,
            left: 50,
            child: IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.white),
              onPressed: _onBeforePressed,
            ),
          ),
        ],
      ),
    );
  }
}
