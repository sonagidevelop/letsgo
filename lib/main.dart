import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:letsgo/page.dart';
import 'package:letsgo/resources/getLocation.dart';
import 'package:letsgo/screen/vv.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PageMain(
        title: 'a',
      ),
    );
  }
}
