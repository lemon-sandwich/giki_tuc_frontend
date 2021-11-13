import 'package:flutter/material.dart';

import 'home_page.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    print(collector);
    return const Scaffold(
      body: Center(
        child: Text('Cart\nWork In Progess',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'GF'
          ),),
      ),
    );
  }
}
