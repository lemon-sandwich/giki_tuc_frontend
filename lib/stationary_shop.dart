import 'package:flutter/material.dart';

class StationaryShop extends StatefulWidget {
  const StationaryShop({Key? key}) : super(key: key);

  @override
  _StationaryShopState createState() => _StationaryShopState();
}

class _StationaryShopState extends State<StationaryShop> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Stationary Shop',
        style: TextStyle(
          fontSize: 50,
        ),),
      ),
    );
  }
}
