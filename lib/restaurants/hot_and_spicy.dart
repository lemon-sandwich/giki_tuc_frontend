import 'package:flutter/material.dart';

class HotAndSpicy extends StatefulWidget {
  const HotAndSpicy({Key? key}) : super(key: key);

  @override
  _HotAndSpicyState createState() => _HotAndSpicyState();
}

class _HotAndSpicyState extends State<HotAndSpicy> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hot & Spicy',
          style: TextStyle(
              fontSize: 50
          ),),
      ),
    );
  }
}