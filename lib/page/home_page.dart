import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/post.dart';
import 'package:provider_demo/viewmodel/post_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));

    await Provider.of<PostViewModel>(context, listen: false).onLoad();

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<PostViewModel>(context, listen: false).onLoad();

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Consumer<PostViewModel>(
        builder: (context, pvm, child) {
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer:
                CustomFooter(builder: (BuildContext context, LoadStatus mode) {
              Widget widget;
              if (mode == LoadStatus.idle) {
                // widget = Text("上拉加载");

                widget = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.loading) {
                pvm.onNextPage();
                widget = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                widget = Text("加载失败");
              } else if (mode == LoadStatus.canLoading) {
                widget = Text("加载更多");
              } else {
                widget = Text("到底了");
              }
              return Container(
                height: 55.0,
                child: Center(child: widget),
              );
            }),
            child: ListView.builder(
              itemBuilder: (c, i) =>
                  Card(child: Center(child: Text(pvm.posts[i].title))),
              itemExtent: 100.0,
              itemCount: pvm.posts.length,
            ),
          );
        },
      ),
    );
  }
}

class PostList extends StatelessWidget {
  final List<Post> posts;

  PostList({this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.posts.length,
      itemBuilder: (context, index) {
        final post = this.posts[index];

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            width: 50,
            height: 100,
          ),
          title: Text(post.title),
        );
      },
    );
  }
}
