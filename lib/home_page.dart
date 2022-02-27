import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearcals/views/welcomePage.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Define authentication function
  void authLongOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  //Start of the UI
  @override
  Widget build(BuildContext context) {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('UserProfile');
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    final Stream<QuerySnapshot> userName = userProfile.snapshots();
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
                accountName: Text(userName.toString()),
                accountEmail: Text(userEmail.toString()),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'resources/profile_picture.jpg',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      image: AssetImage('resources/drawer_background.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
                onTap: () => print('map'),
              ),
              ListTile(
                leading: Icon(Icons.local_dining),
                title: Text('Calories'),
                onTap: () => print('calories'),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorites'),
                onTap: () => print('favorite'),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => print('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Guide'),
                onTap: () => print('guide'),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: authLongOut,
              ),
            ],
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
      ),
    );
  }
}
