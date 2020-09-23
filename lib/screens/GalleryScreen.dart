import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gallery/providers_models/GalleryModel.dart';
import 'package:flutter_gallery/providers_models/ThemeModel.dart';
import 'package:flutter_gallery/components/ListItem.dart';
import 'package:flutter_gallery/screens/PhotoScreen.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final galleryModel = Provider.of<GalleryModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          actions: [
            IconButton(
                icon: ThemeModel().getIcon(),
                onPressed: () => Provider.of<ThemeModel>(context, listen: false)
                    .switchTheme()),
          ],
        ),
        body: ListView.separated(
            itemCount: galleryModel.photoList.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              if (index ~/ 8 + 1 >= galleryModel.currentPage)
                galleryModel.incrementCurrentPage();
              return GestureDetector(
                onTap: () => transitionToPhotoScreen(
                    context, galleryModel.photoList[index].fullUrl),
                child: ListItem(galleryModel.photoList[index]),
              );
            }));
  }

  transitionToPhotoScreen(BuildContext context, String srcPhoto) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PhotoScreen(srcPhoto)));
  }
}
