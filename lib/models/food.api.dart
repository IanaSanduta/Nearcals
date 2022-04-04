// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:nearcals/models/food.dart';
import 'package:http/http.dart' as http;

class FoodApi {
  static Future<List<Food>> getcalories() async {
    var uri = Uri.https('trackapi.nutritionix.com', '/v2/search/instant',
        {"branded": "food_name,brand_name,nf_calories"});

    final response = await http.get(uri, headers: {
      "x-app-id": "bd3f7a80",
      "x-app-key": "43bb77efc418470e481a38f9f73b0891",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    print("print");
    for (var i in data['branded']) {
      _temp.add(i[{}]);
    }
    print("print1");
    print(_temp.length);

    return Food.caloriesFromSnapshot(_temp);
  }

  static Future<List<Food>> getlocation() async {
    var uri = Uri.https('trackapi.nutritionix.com', '/v2/locations',
        {"locations": "name,address,distance_km"});

    final response = await http.get(uri, headers: {
      "x-app-id": "bd3f7a80",
      "x-app-key": "43bb77efc418470e481a38f9f73b0891",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];
/*
    for (var i in data['branded']) {
      _temp.add(i['food_name']['brand_name']['nf_calories']);
    }

 */
    print(_temp.length);

    return Food.caloriesFromSnapshot(_temp);
  }
}









/*
import 'dart:convert';
import 'package:nearcals/models/food.dart';
import 'package:http/http.dart' as http;

class FoodApi {
  static Future<List<Food>> getcalories() async {
    var uri = Uri.https('api.nutritionix.com', '/v1_1/search/',
        {"fields": "item_name,brand_name,nf_calories"});

    final response = await http.get(uri, headers: {
      "appId": "bd3f7a80",
      "x-rapidapi-key": "43bb77efc418470e481a38f9f73b0891",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['hits']) {
      _temp.add(i['fields']);
    }
    print(_temp.length);

    return Food.caloriesFromSnapshot(_temp);
  }
}
*/