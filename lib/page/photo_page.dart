import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/photo.dart';
import 'package:provider_demo/viewmodel/photo_viewmodel.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final int _defaultPhotosPerPageCount = 10;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();

    Provider.of<PhotoViewModel>(context, listen: false).onLoading();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final pvm = Provider.of<PhotoViewModel>(context);

    return ListView.builder(
      itemCount: pvm.photos.length,
      itemBuilder: (context, index) {

      if (index == pvm.photos.length - _nextPageThreshold) {
        pvm.onNextPage(pvm.nextPage);
      }

      final Photo photo = pvm.photos[index];
      return Card(
        child: Column(
          children: <Widget>[
            Image.network(
              photo.thumbnailUrl,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(photo.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      );
    });
  }
}
