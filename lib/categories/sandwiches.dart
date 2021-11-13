import 'package:flutter/material.dart';

class Sandwiches extends StatefulWidget {
  const Sandwiches({Key? key}) : super(key: key);

  @override
  _SandwichesState createState() => _SandwichesState();
}

class _SandwichesState extends State<Sandwiches> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sandwiches\nWork In Progress!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'GF'
          ),),
      ),
    );
  }
}
