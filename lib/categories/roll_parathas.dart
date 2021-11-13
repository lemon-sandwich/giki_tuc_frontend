import 'package:flutter/material.dart';

class RollParathas extends StatefulWidget {
  const RollParathas({Key? key}) : super(key: key);

  @override
  _RollParathasState createState() => _RollParathasState();
}

class _RollParathasState extends State<RollParathas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Roll Parathas\nWork In Progress!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'GF'
          ),),
      ),
    );
  }
}
