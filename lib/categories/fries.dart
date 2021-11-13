import 'package:flutter/material.dart';

class Fries extends StatefulWidget {
  const Fries({Key? key}) : super(key: key);

  @override
  _FriesState createState() => _FriesState();
}

class _FriesState extends State<Fries> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Fries\nWork In Progress!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'GF'
          ),),
      ),
    );
  }
}
