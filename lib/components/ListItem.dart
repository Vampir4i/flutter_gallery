import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/PhotoModel.dart';

class ListItem extends StatelessWidget {
  final PhotoModel _photoModel;

  ListItem(this._photoModel);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 150,
      child: Row(
        children: [
          Image.network(_photoModel.thumbUrl),
          ListItemTextBox(_photoModel.authorName, _photoModel.altDescription)
        ],
      ),
    ));
  }
}

class ListItemTextBox extends StatelessWidget {
  final String _authorName;
  final String _altDescription;

  ListItemTextBox(this._authorName, this._altDescription);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  _authorName != null ? _authorName : '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  _altDescription != null ? _altDescription : '',
                  softWrap: true,
                )
              ],
            )));
  }
}
