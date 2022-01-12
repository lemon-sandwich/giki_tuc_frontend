import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Fry> fetchFries() async {
  var url = Uri.parse('http://10.0.2.2:3000/fries');
  final response = await http
      .get(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Fry.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load items');
  }
}

class Fry extends GetxController{
  List items = [].obs;
  Fry({required this.items});
  factory Fry.fromJson(List json) {
    return Fry(
        items: json
    );
  }
}
