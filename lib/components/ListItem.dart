import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/PhotoModel.dart';

class ListItem extends StatelessWidget {
  final PhotoModel _photoModel;

  ListItem(this._photoModel);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10.0),
      height: 400,
      child: Column(
        children: [
          TitleItem(_photoModel.profileImage, _photoModel.authorName),
          Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Image.network(_photoModel.thumbUrl, fit: BoxFit.fill),
              )),
          BottomItem(_photoModel.altDescription)
        ],
      ),
    ));
  }
}


class TitleItem extends StatelessWidget {
  final String _profileImage;
  final String _authorName;

  TitleItem(this._profileImage, this._authorName);

  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(_profileImage),
              ),
            ),
            Text(
              _authorName != null
                  ? _authorName
                  : '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}

class BottomItem extends StatelessWidget {
  final String _altDescription;
  
  BottomItem(this._altDescription);
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              _altDescription != null
                  ? _altDescription
                  : '',
              softWrap: true,
              style: TextStyle(
                fontSize: 17,
              ))),
    );
  }
}