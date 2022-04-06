// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:nearcals/Calories.dart';
import 'package:nearcals/models/food.dart';
import 'package:http/http.dart' as http;

class FoodApi {
  static Future<List<Food>> getcalories() async {
    var uri = Uri.https('trackapi.nutritionix.com', '/v2/search/instant',
        {"query": "branded"});

    final response = await http.get(uri, headers: {
      "x-app-id": "bd3f7a80",
      "x-app-key": "2487cda686954cf1c762776c8c748e9a",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    print("print");
    for (var i in data['common']) {
      _temp.add(i['food_name']['brand_name']['nf_calories']);
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
      "x-app-key": "2487cda686954cf1c762776c8c748e9a",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['locations']) {
      _temp.add(i['address']);
    }

      //['food_name']['brand_name']['nf_calories']


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
      "x-rapidapi-key": "2487cda686954cf1c762776c8c748e9a",
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

/*


class FoodApi {
  //var query = myController.text;
  static Future<List<Food>> getcalories() async {
    var uri = Uri.https('trackapi.nutritionix.com', '/v2/search/instant',
        {"query": "branded"});

    final response = await http.get(uri, headers: {
      "x-app-id": "bd3f7a80",
      "x-app-key": "2487cda686954cf1c762776c8c748e9a",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    print("print");
    for (var i in data['response']) {
      _temp.add(i['food_name']['brand_name']['nf_calories']);
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
      "x-app-key": "2487cda686954cf1c762776c8c748e9a",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['branded']) {
      _temp.add(i['food_name']['brand_name']['nf_calories']);
    }


    print(_temp.length);

    return Food.caloriesFromSnapshot(_temp);


  }
}

 */
/*
Latest
____________

static Future<List<Food>> getcalories() async {
    var uri = Uri.https('trackapi.nutritionix.com', '/v2/search/instant',
        {"query": "branded"});

    final response = await http.get(uri, headers: {
      "x-app-id": "bd3f7a80",
      "x-app-key": "2487cda686954cf1c762776c8c748e9a",
      "useQueryString": "true"
    });
    print(response.body);
    print(Calories.myController);


    Map data = jsonDecode(response.body);
    List _temp = [];

    print("print");
    for (var i in data['response']) {
      _temp.add(i['food_name']['brand_name']['nf_calories']);
    }
    print("print1");
    print(_temp.length);

    return Food.caloriesFromSnapshot(_temp);
  }
  /*

  static Future<List<Food>> getlocation() async {
    var uri = Uri.https('trackapi.nutritionix.com', '/v2/locations',
        {"locations": "name,address,distance_km"});

    final response = await http.get(uri, headers: {
      "x-app-id": "bd3f7a80",
      "x-app-key": "2487cda686954cf1c762776c8c748e9a",
      "useQueryString": "true"
    });
    print(response.body);


    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['branded']) {
      _temp.add(i['food_name']['brand_name']['nf_calories']);
    }


    print(_temp.length);

    return Food.caloriesFromSnapshot(_temp);

   */



}

 */