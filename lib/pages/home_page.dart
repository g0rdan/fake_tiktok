import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fake_tiktok/models/video_model.dart';
import 'package:fake_tiktok/services/video_service.dart';
import 'package:fake_tiktok/widgets/home/controls/onscreen_controls.dart';
import 'package:fake_tiktok/widgets/home/home_video_renderer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<VideoModel> _videos;
  PageController _scrollController = PageController();

  @override
  void initState() { 
    super.initState();
    _videos = GetIt.I<VideoService>().getVideos();
    _scrollController.addListener((){
      if (_videos.length - _scrollController.page == 1) {
        _videos.addAll(GetIt.I<VideoService>().getVideos());
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: _videos.length,
      itemBuilder: (context, position) {
        return Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              AppVideoPlayer(_videos[position].url), 
              ScreenControls(_videos[position])
            ],
          ),
        );
      },
    );
  }
}
