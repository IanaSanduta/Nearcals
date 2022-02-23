import 'package:flutter/material.dart';
import 'package:nearcals/views/welcomePage.dart';
import 'package:nearcals/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /*
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => WelcomePage()
        ));
      },),*/
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
        body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Column (
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 186),
                       child: Icon(
                        Icons.fastfood,
                        color: Colors.blue,
                        size: 200.0,
                        ),
                  ),
                     RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WelcomePage()),
                          );
                        },
                      child: const Text('Explore'),
                      color: Colors.blue,
                       textColor: Colors.white,
                    ),
                ],
            ),
          ],
        ),
      );
    }
}