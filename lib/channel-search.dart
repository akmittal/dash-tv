import 'package:flutter/material.dart';

class ChannelSearch extends SearchDelegate {
  String selectedResult;
  @override
  List<Widget> buildActions(BuildContext context) {
   
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    selectedResult = query;
    // TODO: implement buildResults
    return Text(selectedResult);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionList = ["1","2","4"];
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index]),
            onTap: () {
              selectedResult = suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}
