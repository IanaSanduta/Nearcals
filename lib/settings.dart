import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/shared/HomeLoadingPage.dart';
import 'package:nearcals/shared/userLang.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  String? langDropdownValue = currentUser.getUserLang();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(text('Settings')),
        ),
        body: ListView(padding: EdgeInsets.zero, children: [
          DropdownButton<String>(
            value: langDropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newLangValue) {
              setState(() {
                langDropdownValue = newLangValue;
              });
            },
            //Add more Language options here  VVV
            items: <String>[langList[0], langList[1], langList[2]]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            onPressed: (() {
              currentUser.setUserLang(langDropdownValue!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeLoadingPage()));
            }),
            child: Text(text('Apply Settings')),
          ),
        ]));
  }
}
