import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final String videoURL;

  AppVideoPlayer(this.videoURL);

  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((onValue) {
      _controller.play();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
      FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (_controller.value.initialized) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Container(
              color: Colors.black,
            );
          }
        }
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
