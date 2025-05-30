import 'package:flutter/material.dart';
import 'package:speedpilot/driving_page/gyroscope_page.dart'; 
import 'package:speedpilot/driving_page/joystick_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCarousel extends StatefulWidget {
  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _pageController =
      PageController(viewportFraction: 0.7); 
  int _currentPage = 0;
  
  final List<Map<String, String>> images = [
    {'image': 'assets/images/nomap.png', 'caption': 'Without Map'},
    {'image': 'assets/images/lidar.jpg', 'caption': 'H222'},
    {'image': 'assets/images/PfuschMobil.png', 'caption': 'Bild 3'},
  ];
  @override

  void initState() {
    super.initState();
    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }
  Future<void> _setGyroToFalse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('gyro', false);
  }
  @override
  void dispose() {
    
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (index != 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GyroscopePage(
                              imagePath: images[index]['image']!)),
                    );
                  }
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoystickPage()));
                  }
                },
                child: buildImage(index),
              );
            },
          ),
        ),
        SizedBox(
            height: 10), 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return buildDot(index);
          }),
        ),
      ],
    );
  }

  Widget buildImage(int index) {

  
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.22, 
        horizontal: 10, 
      ),
      child: Column(

        children: [
          Card(
            elevation: 8.0, 
            shadowColor: Colors.black.withOpacity(0.5),
            color: const Color.fromARGB(200, 25, 25, 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
            
                height: MediaQuery.of(context).size.height * 0.3, 
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset(
                  images[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10), 
          Text(
            images[index]['caption']!,
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Container(
        width: 12,
        height: 12,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 50),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index
              ? Colors.white
              : Colors.grey, 
        ),
      ),
    );
  }
}
