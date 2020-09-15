import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gallery/api/PhotoAPI.dart';
import 'package:flutter_gallery/components/ListItem.dart';
import 'package:flutter_gallery/models/PhotoModel.dart';
import 'package:flutter_gallery/screens/PhotoScreen.dart';

class GalleryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GalleryScreenState();
}

class GalleryScreenState extends State<GalleryScreen> {
  List<PhotoModel> _photoList = [];
  int _currentPage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gallery')),
        body: ListView.separated(
            itemCount: _photoList.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              if (index ~/ 8 + 1 >= _currentPage)
                getPhotos(page: _currentPage++);
              return GestureDetector(
                // onTap: () => print("Tap $index"),
                onTap: () => transitionToPhotoScreen(_photoList[index].fullUrl),
                child: ListItem(_photoList[index]),
              );
            }));
  }

  @override
  initState() {
    getPhotos();
    super.initState();
  }

  List<PhotoModel> decodeResponse(String response) {
    List listResponse = json.decode(response).cast<Map<String, dynamic>>();
    return listResponse
        .map<PhotoModel>((json) => PhotoModel.fromJson(json))
        .toList();
  }

  getPhotos({int page = 1}) async {
    String response = await PhotoAPI.getPhotos(page: page);
    _photoList.addAll(decodeResponse(response));
    setState(() {});
  }

  transitionToPhotoScreen(String srcPhoto) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PhotoScreen(srcPhoto)));
  }
}