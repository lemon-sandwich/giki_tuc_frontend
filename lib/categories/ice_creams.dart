import 'package:flutter/material.dart';

class IceCreams extends StatefulWidget {
  const IceCreams({Key? key}) : super(key: key);

  @override
  _IceCreamsState createState() => _IceCreamsState();
}

class _IceCreamsState extends State<IceCreams> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Ice Creams\nWork In Progress!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'GF'
          ),),
      ),
    );
  }
}
