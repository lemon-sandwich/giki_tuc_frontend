import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
Future<Pizza> fetchPizzas() async {
  var url = Uri.parse('http://10.0.2.2:3000/pizzas');
  final response = await http
      .get(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Pizza.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load items');
  }
}

class Pizza extends GetxController{
  List items = [].obs;
  Pizza({required this.items});
  factory Pizza.fromJson(List json) {
    return Pizza(
        items: json
    );
  }
}
