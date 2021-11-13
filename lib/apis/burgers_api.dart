import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Burger> fetchBurgers() async {
  var url = Uri.parse('http://10.0.2.2:3000/burgers');
  final response = await http
      .get(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Burger.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load items');
  }
}

class Burger {
  final List items;
  Burger({required this.items});
  factory Burger.fromJson(List json) {
    return Burger(
        items: json
    );
  }
}

