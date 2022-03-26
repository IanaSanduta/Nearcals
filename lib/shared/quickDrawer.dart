// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/homePage.dart';
import 'package:nearcals/maps.dart';
import 'package:nearcals/profile.dart';
import 'package:nearcals/settings.dart';
import 'package:nearcals/shared/userLang.dart';
import 'package:nearcals/calories.dart';
import 'package:nearcals/main.dart';

class QuickDrawer extends StatefulWidget {
  const QuickDrawer({Key? key}) : super(key: key);

  @override
  _QuickDrawer createState() => _QuickDrawer();
}

class _QuickDrawer extends State<QuickDrawer> {
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
    return Drawer(
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
                  image: AssetImage('resources/drawer.jpg'), fit: BoxFit.cover),
            ),
          ),
          ListTile(
            iconColor: Colors.blue.shade900,
            leading: const Icon(Icons.local_dining),
            title: Text(text('Home')),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ),
          ),
          ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.person),
              title: Text(text('Profile')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              }
              /*onTap: () => Navigator.push(

                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              ),
              */
              ),
          ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.map),
              title: Text(text('Map')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Maps()));
              }),
          ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.local_dining),
              title: Text(text('Calories')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Calories()));
              }),
          ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.favorite),
              title: Text(text('Favorites')),
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
              title: Text(text('Settings')),
              onTap: () {
                //TODO: Implement Settings

                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              }),
          ListTile(
              iconColor: Colors.blue.shade900,
              leading: const Icon(Icons.description),
              title: Text(text('Guide')),
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
            title: Text(text('Logout')),
            onTap: () => authLongOut(),
          ),
        ],
      ),
    );
  }
}
