import 'package:flutter/material.dart';
import 'package:nearcals/models/food.api.dart';
import 'package:nearcals/models/food.dart';
import 'package:nearcals/views/widgets/recipe_card.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('NearCals'),
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) {
                  return RecipeCard(
                      name: _foodlist[index].name,
                      calories: _foodlist[index].calories,
                      brandName: _foodlist[index].brandName
                  );
              }
        )
    );
  }
}

