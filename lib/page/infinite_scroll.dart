import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/post.dart';
import 'package:provider_demo/viewmodel/post_viewmodel.dart';

class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({Key key}) : super(key: key);

  @override
  _InfiniteScrollState createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  void initState() {
    super.initState();

    Provider.of<PostViewModel>(context, listen: false).onLoad();

    _controller.addListener(() {
      var isEnd = _controller.offset == _controller.position.maxScrollExtent;
      if (isEnd) {
        Provider.of<PostViewModel>(context, listen: false).onNextPage();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Infinite Scrolling'),
        ),
        body: Consumer<PostViewModel>(builder: (context, post, child) {
          return Stack(children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(post.posts[index].title),
                  onTap: () {},
                );
              },
              itemCount: post.posts.length,
              controller: _controller,
            ),
            post.isLoading
                ? Container(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : Container(), //if isLoading flag is true it'll display the progress indicator
          ]);
        }));
  }
}
