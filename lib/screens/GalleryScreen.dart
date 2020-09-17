import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gallery/Theme.dart';
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
  String _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          actions: [
            IconButton(
                icon: MyTheme().getIcon(),
                onPressed: () => MyTheme().switchTheme()),
          ],
        ),
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
    _response = await PhotoAPI.getPhotos(page: page)
        .catchError((onError) => startPeriodicRequest(page));
    _photoList.addAll(decodeResponse(_response));
    setState(() {});
  }

  transitionToPhotoScreen(String srcPhoto) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PhotoScreen(srcPhoto)));
  }

  startPeriodicRequest(int page) {
    Timer.periodic(Duration(milliseconds: 5000), (timer) async {
      _response = await PhotoAPI.getPhotos(page: page)
          .then((response) {
            timer.cancel();
            return response;
          });
      _photoList.addAll(decodeResponse(_response));
      setState(() {});
    });
  }
}
