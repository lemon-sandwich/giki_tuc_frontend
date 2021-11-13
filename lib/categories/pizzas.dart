import 'package:flutter/material.dart';

class Pizzas extends StatefulWidget {
  const Pizzas({Key? key}) : super(key: key);

  @override
  _PizzasState createState() => _PizzasState();
}

class _PizzasState extends State<Pizzas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Pizzas\nWork In Progress!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              fontFamily: 'GF'
          ),),
      ),
    );
  }
}
