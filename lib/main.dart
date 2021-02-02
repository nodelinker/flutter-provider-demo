import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/page/home_page.dart';
import 'package:provider_demo/page/infinite_scroll.dart';
import 'package:provider_demo/page/photo_page.dart';
import 'package:provider_demo/viewmodel/photo_viewmodel.dart';
import 'package:provider_demo/viewmodel/post_viewmodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostViewModel()),
        ChangeNotifierProvider(create: (context) => PhotoViewModel()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: PhotoPage(),
      ),
    );
  }
}
