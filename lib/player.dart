import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iptv/channel.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  static const routeName = '/player';
  @override
  State<StatefulWidget> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    final PlayerArguments args = ModalRoute.of(context).settings.arguments;
    videoPlayerController = VideoPlayerController.network(args.channel.url);
    videoPlayerController.setVolume(1.0);

    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    final playerWidget = Chewie(
      controller: chewieController,
    );
    return Scaffold(appBar: AppBar(title:Text(args.channel.name)), body: playerWidget);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}

class PlayerArguments {
  final Channel channel;
  PlayerArguments(this.channel);
}
