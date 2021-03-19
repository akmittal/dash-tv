import 'package:flutter/material.dart';

class ChannelName extends StatelessWidget {
  final String name;
  ChannelName(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      
      ),
    );
  }
}
