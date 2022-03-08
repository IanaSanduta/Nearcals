// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/favorites.dart';
import 'package:nearcals/maps.dart';
import 'package:nearcals/profile.dart';
import 'package:nearcals/register.dart';
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
    pullUserData();
    String? userName = currentUser.getUserName();
    String? userEmail = currentUser.getEmail();
    userName ??= FirebaseAuth.instance.currentUser?.displayName;
    userEmail ??= FirebaseAuth.instance.currentUser?.email;
    userName ??= run;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userName),
                accountEmail: Text(userEmail!),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'resources/default_user.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  //image: const DecorationImage(image: AssetImage('resources/drawer.jpg'), fit: BoxFit.cover),
                ),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                ),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.map),
                title: const Text('Map'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Maps()),
                ),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.local_dining),
                title: const Text('Calories'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Calories()),
                ),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: () => favListTest(),
              ),
              const Divider(),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => print('Settings'),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.description),
                title: const Text('Guide'),
                onTap: () => print('guide'),
              ),
              const Divider(),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Exit'),
                onTap: authLongOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
