import 'dart:async';
import 'World_State.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStateScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {//well you can write any widget name it will not effect it
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Center(
                      child: Image(image: AssetImage('images/realvirus.png')),
                    ),
                  ), //here child is image which we have use in line 44 for specific
                );
              }),
          SizedBox(height: MediaQuery.of(context).size.height * .08),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Covid 19 \n Tracker App",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
