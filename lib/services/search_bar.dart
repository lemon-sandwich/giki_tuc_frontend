import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:giki_tuc/categories/burgers.dart';
import 'package:giki_tuc/categories/pizzas.dart';
import 'package:giki_tuc/controllers/dark_theme_controller.dart';
import 'package:page_transition/page_transition.dart';

// Press CTRL+o to check more overrides

class DataSearch extends SearchDelegate<String> {

  final items = [
    'Zinger Burger',
    'Jalapeno Burger',
    'Cheese Pizza',


  ];

  final recent_items = [
    'Zinger Burger',
    'Jalapeno Burger',
  ];



  @override
  ThemeData appBarTheme(BuildContext context) {
    final darkThemeController = Get.find<DarkThemeController>();
    return ThemeData(
      scaffoldBackgroundColor: darkThemeController.darkMode.value? Colors.black: Colors.white,
      colorScheme: darkThemeController.darkMode.value? ColorScheme.dark(
        primary: Colors.white
      ):ColorScheme.light(
        primary: Colors.white,
      ));

  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {
      query = "";
    }, icon: Icon(
      Icons.clear,
      color: Colors.green,
    ),)];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          color: Colors.green,
          progress: transitionAnimation),
    onPressed: () {
        close(context, '');
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Hello'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion_items = query.isEmpty? recent_items:items.where((q) => q.contains(query)).toList();
    return ListView.builder(itemBuilder: (context,index) => ListTile(
      onTap: () {
        if(suggestion_items[index].contains('Burger'))
            Navigator.push(context, PageTransition(child: Burgers(), type: PageTransitionType.fade));
        else if(suggestion_items[index].contains('Pizza'))
          Navigator.push(context, PageTransition(child: Pizzas(), type: PageTransitionType.fade));
      },
      title: Text(suggestion_items[index])/*RichText(text: TextSpan(
          text: suggestion_items[index].substring(0,query.length),style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      children: [
        TextSpan(
          text: suggestion_items[index].substring(query.length),
          style: TextStyle(
            color: Colors.grey,
          )
        )
      ]),),*/

    ),
    itemCount: suggestion_items.length,);
  }
}