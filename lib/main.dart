import 'package:flutter/material.dart';
import 'package:flutter_gallery/providers_models/GalleryModel.dart';
import 'package:flutter_gallery/providers_models/ThemeModel.dart';
import 'package:flutter_gallery/screens/GalleryScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeModel>(create: (context) => ThemeModel()),
      ChangeNotifierProvider<GalleryModel>(create: (context) => GalleryModel())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeModel>(context).currentTheme(),
      home: GalleryScreen(),
    );
  }
}
