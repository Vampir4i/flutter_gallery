import 'package:flutter/material.dart';
import 'package:flutter_gallery/Theme.dart';
import 'package:flutter_gallery/screens/GalleryScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    MyTheme().addListener(() {
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: MyTheme().currentTheme(),
      home: GalleryScreen(),
    );
  }
}