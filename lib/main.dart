import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fake_tiktok/bottom_nav_bar.dart';
import 'package:fake_tiktok/pages/home_page.dart';
import 'package:fake_tiktok/widgets/home/home_header.dart';

import 'services/video_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GetIt.I.registerSingleton(VideoService());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            HomeScreen(),
            BottomNavigation(),
            homeHeader(),
          ],
        ),
      ),
    );
  }
}
