// ignore_for_file: avoid_print

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
