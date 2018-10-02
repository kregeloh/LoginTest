import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home Screen'),
      ),
      body:
      new Center(
        child:
        new Text(
            "Logged in",
            style: new TextStyle(fontSize: 32.0,
                color: const Color(0xFFff0f03),
                fontWeight: FontWeight.w600,
                fontFamily: "Roboto")
        ),
      ),
    );
  }
}