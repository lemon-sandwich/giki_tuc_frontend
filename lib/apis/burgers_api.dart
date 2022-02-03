import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Burger> fetchBurgers() async {
  var url = Uri.parse('http://10.0.2.2:3000/burgers');
  final response = await http
      .get(url, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Burger.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load items');
  }
}

class Burger extends GetxController{
  List items = [].obs;
  Burger({required this.items});
  factory Burger.fromJson(List json) {
    return Burger(
        items: json
    );
  }
}

/*
class Burger2 extends GetxController{
  int id;
  String name;
  String description;
  int price;
  int ordered;
  bool availability;
  String photo_url;
  Burger2({
    required this.id,
    required this.name,
  required this.photo_url,
  required this.description,
  required this.availability,
  required this.ordered,
  required this.price

  });
  factory Burger2.fromJson(Map<String,dynamic> json) {
    return Burger2(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price:json['price'],
      ordered: json['ordered'],
      availability: json['availability'],
      photo_url: json['photo_url'],
    );
  }
}

Future<Burger2> updateBurger(Map items,int number,int ordered) async {
  print(ordered);
  print(items['name']);
  int newOrdered = items['ordered'] + ordered;
  final response = await http.put(
    Uri.parse('http://10.0.2.2:3000/burgers/${number+1}'),
    headers:{
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': "*"
    },
    body: jsonEncode({
      'id': items['id'],
      'name': items['name'],
      'description': items['description'],
      'price':items['price'],
      'ordered': newOrdered,
      'availability': items['availability'],
      'photo_url': items['photo_url'],
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Burger2.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update Burger.');
  }
}


*/
