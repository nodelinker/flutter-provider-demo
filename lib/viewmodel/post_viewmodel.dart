

import 'package:flutter/widgets.dart';
import 'package:provider_demo/model/post.dart';
import 'package:provider_demo/services/webservices.dart';

class PostViewModel with ChangeNotifier{

  int _currentPage = 0;
  int _nextPage = 0;
  List<Post> posts = List<Post>();

  bool isLoading = false;

  onLoad() async {
    final res = await WebServices().fetchPosts(0);
    if(res != null){
      this.posts = res;
      notifyListeners();
    }
  }

  onNextPage() async {
    _nextPage = _currentPage + 1;
    _currentPage = _nextPage;

    isLoading = true;
    notifyListeners();

    final res = await WebServices().fetchPosts(_nextPage);

    isLoading = false;
    notifyListeners();

    if(res != null){
      this.posts.addAll(res);
      notifyListeners();
    } 
  }
}