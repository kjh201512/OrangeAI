import 'package:flutter/material.dart';
import 'package:orangeai/user.dart';
import 'dart:async';

import 'call.dart';
import 'chat_screen_2.dart';
import 'chat_screen_3.dart';
import 'manual.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Specify the home screen
      routes: {
        '/chat2': (context) => ChatScreen2(),
        '/chat3': (context) => ChatScreen3(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width,
              height: size.height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 58,
                    top: 690,
                    child: Text(
                      '만나서 반갑습니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.02,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 42,
                    top: 260,
                    child: Container(
                        width: 270,
                        height: 230,
                        child: Image.asset("image/orange_icon.png")),
                  ),
                  Positioned(
                    left: 42,
                    top: 410,
                    child: Container(
                        width: 280,
                        height: 220,
                        child: Image.asset("image/orange_logo.png")),
                  ),
                  Positioned(
                    left: 95.86,
                    top: 225.21,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(0.52),
                      child: Text(
                        '혼자 산 지 얼마나 오랜지',
                        style: TextStyle(
                          color: Color(0xFFFF763B),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void navigateToChat(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "image/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Image.asset(
              "image/orange_main.png",
              width: 60,
              height: 60,
            ),
          ),
          Positioned(
            top: 60,
            left: 10,
            child: Image.asset(
              "image/puzzle.png",
              width: 60,
              height: 60,
            ),
          ),
          Positioned(
            top: 70,
            right: 10,
            child: Column(
              children: [
                RoundedButton(
                  text: "내 정보",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: "긴급전화",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CallScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: "앱 설명",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManualScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width,
                height: size.height,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        DateTime now = DateTime.now();
                        int hour = now.hour;

                        if (hour >= 7 && hour < 14) {
                          navigateToChat(context, '/chat2');
                        } else if (hour >= 14 && hour < 19) {
                          navigateToChat(context, '/chat3');
                        } else {
                          navigateToChat(context, '/');
                        }
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 15,
                              offset: Offset(10, 10),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 42.92,
                            height: 71.53,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("image/record_icon.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoundedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: Size(85, 85),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,  // Adjust font size to fit the button
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      ),
    );
  }
}
