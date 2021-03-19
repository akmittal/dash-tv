import 'package:flutter/material.dart';
import 'package:iptv/channel-list.dart';
import 'package:iptv/languages.dart';
import 'package:iptv/list-loader.dart';
import 'package:iptv/player.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ListLoader(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      theme:
          ThemeData(brightness: Brightness.light, primaryColor: Colors.black, accentColor: Colors.pink),
      routes: {
        '/': (context) => ChannelList(),
        '/player': (context) => Player(),
        "/languages": (context) => LanguageSelector()
      },
    );
  }
}
