import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "./languages.dart";

class LanguageModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("languagesSet", true);
              Navigator.pop(context, true);
            },
            child: Text("Continue"),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                // backgroundColor: Colors.black26,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 4, 4, 10),
                child: Text(
                  "Select Languages",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                ),
              ),
              LanguageContainer(),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        ),
      ),

      backgroundColor: Colors.white.withOpacity(
          1), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    );
  }
}
