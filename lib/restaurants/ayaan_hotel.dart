import 'package:flutter/material.dart';

class AyaanHotel extends StatefulWidget {
  const AyaanHotel({Key? key}) : super(key: key);

  @override
  _AyaanHotelState createState() => _AyaanHotelState();
}

class _AyaanHotelState extends State<AyaanHotel> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Ayaan Hotel',
        style: TextStyle(
          fontSize: 50
        ),),
      ),
    );
  }
}
