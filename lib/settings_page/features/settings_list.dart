import 'package:flutter/material.dart';

class SettingsList extends StatefulWidget {
  @override
  _SettingsList createState() => _SettingsList();
}

class _SettingsList extends State<SettingsList> {
  final List<CardOption> settings = [
    CardOption(
      title: "Gyroscope",
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
  bool _enable = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settings.length,
      itemBuilder: (context, index) {
        final setting = settings[index];
        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1,
          left:  MediaQuery.of(context).size.height * 0.2,
          right:  MediaQuery.of(context).size.height * 0.2),
          height: MediaQuery.of(context).size.height * 0.15,
          child: Card(
            color: setting.color,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,// Texte links ausrichten
                children: [
                  if (index == 0)
                    Text(
                      setting.title,
                      style: TextStyle(
                        color: setting.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      
                      ),
                    ),
                  if (index == 0)
                    CustomSwitch(value:_enable, onChanged:(bool val){
                      setState(() {
                        _enable = val;
                      });
                    }),
                  if (index ==1)
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

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 45.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? Colors.green
                  : Colors.grey
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment:
                    widget.value ? ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerRight : Alignment.centerLeft ) : ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerLeft : Alignment.centerRight),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}