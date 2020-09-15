import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoScreen extends StatelessWidget {
  final String _srcPhoto;

  PhotoScreen(this._srcPhoto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo Screen')),
      body: Stack(children: [
        Center(child: CircularProgressIndicator()),
        Center(child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: _srcPhoto
        ))
      ])
    );
  }
}