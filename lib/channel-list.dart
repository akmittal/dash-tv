import 'package:flutter/material.dart';
import 'package:iptv/channel-name.dart';
import 'package:iptv/channel-search.dart';
import 'package:iptv/channel.dart';
import 'package:iptv/language-modal.dart';
import 'package:iptv/player.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './list-loader.dart';

class ChannelList extends StatefulWidget {
  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  List<Channel> channelList = [];
  List<String> selecetedLanguages = [];
  Channel _selectedChannel;
  TabController _tabController;

  afterBuild() async {
    print("after build");
    DefaultTabController.of(context).addListener(() {
      print("clicked");
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool languagesSet = prefs.getBool("languagesSet");
    if (!languagesSet) {
      showGeneralDialog(
          // barrierDismissible:true,
          context: context,
          pageBuilder: (context, obj, obj2) => LanguageModal());
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterBuild();
    });
    return Consumer<ListLoader>(
        builder: (ctx, list, child) => DefaultTabController(
              length: list.getFilterCatgories(list.selectedLanguageList).length,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                      isScrollable: true,
                      tabs: list.getFilterCatgories(list.selectedLanguageList)
                          .map((e) => Tab(child: Text(e)))
                          .toList()),
                  title: Text("Channels"),
                  actions: <Widget>[
                  
                    IconButton(
                        icon: const Icon(Icons.settings_rounded),
                        tooltip: 'Go to the next page',
                        onPressed: () {
                          Navigator.pushNamed(context, "/languages");
                        }),
                  ],
                ),
                body: TabBarView(
                  children: list
                      .getFilterCatgories(list.selectedLanguageList)
                      .map((category) => Container(
                            color: Colors.black87,
                            child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                children: list
                                    .getChannelByfilter(
                                      
                                        category, list.selectedLanguageList)
                                    .map<Widget>((channel) => Card(
                                          child: InkWell(
                                            onTap: () {
                                              _handleChannelTapped(channel);
                                            },
                                            child: Container(
                                              height: 200,
                                              child: channel.logo != null
                                                  ? Image.network(
                                                      channel.logo,
                                                      errorBuilder: (context,
                                                          obj, statck) {
                                                        return ChannelName(
                                                            channel.name);
                                                      },
                                                    )
                                                  : ChannelName(channel.name),
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          ))
                      .toList(),
                ),
              ),
            ));
  }

  void _handleChannelTapped(Channel channel) {
    setState(() {
      _selectedChannel = channel;
    });
    Navigator.pushNamed(context, Player.routeName,
        arguments: PlayerArguments(channel));
  }
}
