import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iptv/channel.dart';
import 'package:shared_preferences/shared_preferences.dart';

const blockList = ["AdultIPTV"];
const blockedCategories = ["XXX"];

class ListLoader extends ChangeNotifier {
  final url = 'https://iptv-org.github.io/iptv/channels.json';
  final List<Channel> channelList = [];
  List<Channel> filteredChannelList = [];
  Set<Language> languageList = new Set();
  Set<String> selectedLanguageList = new Set();
  Set<String> allCategories = Set.from(["All Channels"]);
  Set<String> filterCategories = Set.from(["All Channels"]);
  String selectedCategory = "All Channels";

  ListLoader() {
    getData().then((value) async {
      getAllLanguages();
      await getSelectedLanguageList();
      notifyListeners();
    });
  }
  bool isChannelBanned(Channel channel) {
    return blockList
            .any((blockElement) => channel.name.contains(blockElement)) ||
        blockedCategories
            .any((blockedCategory) => blockedCategory == channel.category);
  }

  Future<List<Channel>> getData() async {
    if (channelList.length != 0) {
      return channelList;
    }
    var res = await DefaultCacheManager().getSingleFile(url);
    var data = await res.readAsString();
    List<dynamic> decoded = jsonDecode(data);
    for (var i = 0; i < decoded.length; i++) {
      Channel newChannel = Channel.fromJson(decoded[i]);
      if (!isChannelBanned(newChannel)) {
        channelList.add(newChannel);
        if (!allCategories.contains(newChannel.category) &&
            newChannel.category != null) allCategories.add(newChannel.category);
      }
    }
    filteredChannelList = channelList.toList();
    return channelList;
  }

  List<Language> getAllLanguages() {
    if (channelList.length == 0) {
      return [];
    }

    for (var i = 0; i < channelList.length; i++) {
      channelList[i].languages.forEach((element) {
        if (!languageList.map((e) => e.code).contains(element.code)) {
          languageList.add(element);
        }
      });
    }

    return languageList.toList();
  }

  List<Channel> getChannelByfilter(String category, Set<String> langSet) {
    List<Channel> filterList = [];
    if (channelList.length == 0) {
      filteredChannelList = [];
    }

    for (var i = 0; i < channelList.length; i++) {
      if (channelList[i]
                  .languages
                  .map((e) => e.code)
                  .toSet()
                  .intersection(langSet)
                  .length >
              0 &&
          (channelList[i].category == category || category == "All Channels")) {
        filterList.add(channelList[i]);
      }
    }
    filteredChannelList = filterList.toList();
    notifyListeners();
    return filteredChannelList;
  }

  List<String> getFilterCatgories(Set<String> selectedLanguageList) {
    List<String> filterCategotryList = ["All Channels"];
    for (var i = 0; i < channelList.length; i++) {
      if (channelList[i]
                  .languages
                  .map((e) => e.code)
                  .toSet()
                  .intersection(selectedLanguageList)
                  .length >
              0 && channelList[i].category!=null && !filterCategotryList.contains(channelList[i].category)
          ) {
        filterCategotryList.add(channelList[i].category);
      }
    }

    notifyListeners();
    return filterCategotryList;
  }

  setLanguages(List<String> lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguageList = lang.toSet();
    prefs.setStringList("selectedLanguages", lang);
    notifyListeners();
  }

  Future getSelectedLanguageList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    selectedLanguageList = prefs.getStringList("selectedLanguages").toSet();
  }

  getAllCategories() {
    return allCategories.toList();
  }

  toggleLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguageList.contains(lang)
        ? selectedLanguageList.remove(lang)
        : selectedLanguageList.add(lang);

    prefs.setStringList("selectedLanguages", selectedLanguageList.toList());

    notifyListeners();
  }
}
