import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<IceCream> fetchIceCreams() async {
  var url = Uri.parse('http://10.0.2.2:3000/icecreams');
  final response = await http
      .get(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return IceCream.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load items');
  }
}

class IceCream extends GetxController{
  List items = [].obs;
  IceCream({required this.items});
  factory IceCream.fromJson(List json) {
    return IceCream(
        items: json
    );
  }
}
