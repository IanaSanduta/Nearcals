// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/maps.dart';
import 'package:nearcals/profile.dart';
import 'Calories.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Define authentication function
  void authLongOut() {
    currentUser.clearUser();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    String? userName = currentUser.getUserName();
    String? userEmail = currentUser.getEmail();
    userName ??= 'Username';
    userEmail ??= 'Email';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    image: NetworkImageWithRetry(
                        currentUser.getUserImageURL().toString()),
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                image: const DecorationImage(
                    image: AssetImage('resources/drawer.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
<<<<<<< HEAD
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.local_dining),
              title: const Text('Home'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              ),
            ),
            ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => Navigator.push(
=======
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                }
                /*onTap: () => Navigator.push(
>>>>>>> a5390ac24ba122e179892b102f0b7b5ff3d6bd25
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              ),
              */
                ),
            ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.map),
                title: const Text('Map'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Maps()));
                }),
            ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.local_dining),
                title: const Text('Calories'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Calories()));
                }),
            ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: () {
                  //TODO: Implement Favorites
                  print('Favorites');
                  /*
                  Navigator.pop(context);
                  //Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Favorites()));
                */
                }),
            const Divider(),
            ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  //TODO: Implement Settings
                  print('Settings');
                  /*
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                */
                }),
            ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.description),
                title: const Text('Guide'),
                onTap: () {
                  //TODO: Implement Guide
                  print('Guide');
                  /*
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Guide()));
                */
                }),
            const Divider(),
            ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () => authLongOut(),
            ),
          ],
        ),
      ),
    );
  }
}
