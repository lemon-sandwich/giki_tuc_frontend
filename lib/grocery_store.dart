import 'package:flutter/material.dart';

class GroceryStore extends StatefulWidget {
  const GroceryStore({Key? key}) : super(key: key);

  @override
  _GroceryStoreState createState() => _GroceryStoreState();
}

class _GroceryStoreState extends State<GroceryStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: const Center(
        child: Text('Grocery Store',
          style: TextStyle(
            fontSize: 50,
          ),),
      ),
    );
  }
}
