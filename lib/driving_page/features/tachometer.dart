import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import './gas_joystick.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tachometer extends StatefulWidget {
  @override
  _TachometerState createState() => _TachometerState();
}

class _TachometerState extends State<Tachometer> {
  double _currentValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSpeedPolling();
  }

  void _startSpeedPolling() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      final prefs = await SharedPreferences.getInstance();
      final newSpeed = prefs.getDouble('speed') ?? 0.0;

      if (newSpeed != _currentValue && newSpeed >= 0.0) {
        setState(() {
          _currentValue = newSpeed;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 10,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 10,
                gradient: SweepGradient(
                  colors: [
                    Colors.red.shade300,
                    Colors.red.shade900,
                  ],
                  stops: [0.0, 1.0],
                ),
                startWidth: 15,
                endWidth: 15,
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: _currentValue,
                needleLength: 0.8,
                lengthUnit: GaugeSizeUnit.factor,
                needleStartWidth: 0,
                needleEndWidth: 5,
                needleColor: Colors.white.withOpacity(0.7),
                knobStyle: KnobStyle(
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  sizeUnit: GaugeSizeUnit.factor,
                  knobRadius: 0.0,
                ),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: Text(
                    _currentValue.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
                angle: 90,
                positionFactor: 0.5,
              ),
            ],
            axisLabelStyle: GaugeTextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            interval: 2,
          ),
        ],
      ),
    );
  }
}
