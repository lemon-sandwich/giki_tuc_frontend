import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<RollParatha> fetchRollParathas() async {
  var url = Uri.parse('http://10.0.2.2:3000/rollparathas');
  final response = await http
      .get(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return RollParatha.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load items');
  }
}

class RollParatha extends GetxController{
  List items = [].obs;
  RollParatha({required this.items});
  factory RollParatha.fromJson(List json) {
    return RollParatha(
        items: json
    );
  }
}
