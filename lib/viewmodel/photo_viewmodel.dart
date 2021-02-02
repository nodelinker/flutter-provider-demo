import 'package:flutter/widgets.dart';
import 'package:provider_demo/model/photo.dart';
import 'package:provider_demo/services/webservices.dart';

class PhotoViewModel with ChangeNotifier {
  int currentPage = 0;
  int nextPage = 0;
  List<Photo> photos = List<Photo>();
  bool isLoading = false;


  onLoading() async {
    this.nextPage = this.currentPage + 1;

    final res = await WebServices().fetchPhotos(0);
    if (res != null && !res.isEmpty) {
      this.photos.addAll(res);
      notifyListeners();
    }
  }

  onNextPage(int page) async {
    this.currentPage = page;
    this.nextPage = this.currentPage + 1;

    final res = await WebServices().fetchPhotos(page);

    if (res != null && !res.isEmpty) {
      this.photos.addAll(res);
      notifyListeners();
    }
  }
}
