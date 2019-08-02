import 'package:flutter/material.dart';
import 'package:go_tech_test/screens/activity_feed.dart';



void main() => runApp(GoApp());

class GoApp extends StatefulWidget {

  @override
  _GoAppState createState() => _GoAppState();
}

class _GoAppState extends State<GoApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Demo App',
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
      ),
      home: ActivityFeed(title: "GO"),
    );
  }
}

