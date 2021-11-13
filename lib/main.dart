import 'dart:async';
import 'package:giki_tuc/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),);
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _visible = false;

  void fadeIn(){
    setState(() {
      _visible = !_visible;
      Timer(const Duration(milliseconds: 1500), fadeOut);
    });
  }
  void fadeOut(){
    setState(() {
      _visible = !_visible;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(
        const Duration(milliseconds: 1500), fadeIn);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 1000),
              child: const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Fade(const Text(
                'GIKI',
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 80,
                  color: Colors.green,
                ),)
              ),
            ),
            Center(
              child: Fade(const Text(
                'Eats',
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 75,
                  color: Colors.white,
                ),)
              ),
            ),

          ],
        )
    );
  }
  Widget Fade(Widget widget) {

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: widget,
    );
  }
}
