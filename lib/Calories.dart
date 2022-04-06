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
  final myController = TextEditingController()..text;


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

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
          title:
           TextField(
            controller: myController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
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

