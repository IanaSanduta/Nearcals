// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nearcals/classes/userClass.dart';
import 'package:nearcals/shared/HomeLoadingPage.dart';
import 'package:nearcals/shared/userLang.dart';

class UserCreatedPage extends StatefulWidget {
  const UserCreatedPage({Key? key}) : super(key: key);
  @override
  State<UserCreatedPage> createState() => _UserCreatedPage();
}

class _UserCreatedPage extends State<UserCreatedPage> {
  String? langDropdownValue = 'English';
  @override
  Widget build(BuildContext context) {
    currentUser.setUserLang('English');
    return Scaffold(
        appBar: AppBar(
          title: Text(text('Congratulations Account Was Created')),
        ),
        body: ListView(padding: EdgeInsets.zero, children: [
          Text(text('Select Language')),
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
