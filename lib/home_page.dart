import 'package:flutter/material.dart';
import 'classes/userClass.dart';
import 'classes/dataBase.dart';
import 'profile.dart';
import 'main.dart';

class HomePage extends StatefulWidget {

  //Add User Class parameter to constructor
  final UserProfile account;
  const HomePage({Key? key, required this.account}) : super(key: key) ;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    //Retrieve login data
    UserProfile userData = widget.account;
    String userName = userData.getUserName();
    String userEmail = userData.getEmail();
    debugPrint(userData.toString());

    //Logout function
    void authLongOut() {
      DataBase().longOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    }

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
                  image: const DecorationImage(image: AssetImage('resources/drawer.jpg'), fit: BoxFit.cover),
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
                onTap: () => print('map'),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.local_dining),
                title: const Text('Calories'),
                onTap: () => print('calories'),
              ),
              ListTile(
                iconColor: Colors.blue.shade900,
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: () => print('favorite'),
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
    );
  }

}
