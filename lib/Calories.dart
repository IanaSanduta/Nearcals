// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
          leading: const Icon(Icons.local_dining),
          title: const Text('Calories'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(itemBuilder: (context, index) {
                return RecipeCard(
                    name: _foodlist[index].name,
                    calories: _foodlist[index].calories,
                    brandName: _foodlist[index].brandName);
              }));
  }
  /*
  @override

  Widget build(BuildContext context) {
    return Container();
  }

   */

}
