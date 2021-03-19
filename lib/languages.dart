import 'package:flutter/material.dart';

import 'package:iptv/channel.dart';
import 'package:iptv/list-loader.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  List<Language> _allLanguages = [];
  Set<String> _selectedLanguages = new Set();
  @override
  void initState() {
    super.initState();

    _getSharedPreferences();
  }

  _getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList("selectedLanguages");
    setState(() {
      _selectedLanguages = data.toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Languages"),
        ),
        // bottomSheet: ButtonBar(children: [
        //   OutlinedButton(onPressed: (){},child: Text("Continue"),)
        // ],),
        body: LanguageContainer());
  }
}

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ListLoader>(
        builder: (context, listLoader, obj) => Wrap(
          spacing: 10.0, // gap between adjacent chips
          alignment: WrapAlignment.center,
          runSpacing: 2.0, // gap between lines
          children: listLoader.languageList.map(
            (language) {
              var isSelected =
                  listLoader.selectedLanguageList.contains(language.code);
              return InputChip(
                  onPressed: () {
                    listLoader.toggleLanguage(language.code);
                 
                  },
                  backgroundColor:
                      isSelected ? Colors.pink : Colors.grey.shade200,
                  label: Text(
                    language.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ));
            },
          ).toList(),
        ),
      ),
    );
  }
}
