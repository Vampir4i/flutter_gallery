import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gallery/api/PhotoAPI.dart';
import 'package:flutter_gallery/models/PhotoModel.dart';

class GalleryModel with ChangeNotifier {
  List<PhotoModel> _photoList = [];
  static GalleryModel _galleryModel;
  int _currentPage = 1;
  String _response;

  GalleryModel.primary() {
    getPhotos();
  }

  factory GalleryModel() {
    if (_galleryModel == null) _galleryModel = GalleryModel.primary();
    return _galleryModel;
  }

  List<PhotoModel> get photoList => _photoList;
  int get currentPage => _currentPage;

  getPhotos({int page = 1}) async {
    _response = await PhotoAPI.getPhotos(page: page)
        .catchError((onError) => startPeriodicRequest(page));
    _photoList.addAll(decodeResponse(_response));
    notifyListeners();
  }

  incrementCurrentPage() {
    getPhotos(page: ++_currentPage);
  }

  List<PhotoModel> decodeResponse(String response) {
    List listResponse = json.decode(response).cast<Map<String, dynamic>>();
    return listResponse
        .map<PhotoModel>((json) => PhotoModel.fromJson(json))
        .toList();
  }

  startPeriodicRequest(int page) {
    Timer.periodic(Duration(milliseconds: 5000), (timer) async {
      _response = await PhotoAPI.getPhotos(page: page).then((response) {
        timer.cancel();
        return response;
      });
      _photoList.addAll(decodeResponse(_response));
      notifyListeners();
    });
  }


}
