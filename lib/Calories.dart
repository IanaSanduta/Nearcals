// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nearcals/shared/CalorieLoadingPage.dart';
import 'package:nearcals/views/widgets/recipe_card.dart';

import 'models/food.api.dart';
import 'models/food.dart';

class Calories extends StatefulWidget {
  const Calories({Key? key}) : super(key: key);

  @override
  _CaloriesState createState() => _CaloriesState();
}

class _CaloriesState extends State<Calories> {
  late List<Food> _foodlist;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getcalories();
  }

  /*
  if(_foodlist == null) {
     Navigator.push(context,
         MaterialPageRoute(builder: (context) => const CalorieLoadingPage()));
   }
   */
  Future<void> getcalories() async {
    _foodlist = await FoodApi.getcalories();

      setState(() {
        _isLoading = false;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calories'),
        ),
        body: ListView.builder(
                itemCount: _foodlist.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      name: _foodlist[index].name,
                      calories: _foodlist[index].calories,
                      brandName: _foodlist[index].brandName);
                })
    );
  }

}
